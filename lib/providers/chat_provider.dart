import 'package:agrisense/apis/api_service.dart';
import 'package:agrisense/constants/constants.dart';
import 'package:agrisense/hive/boxes.dart';
import 'package:agrisense/hive/chat_history.dart';
import 'package:agrisense/hive/settings.dart';
import 'package:agrisense/hive/user_model.dart';
import 'package:agrisense/models/message.dart';
import 'package:flutter/foundation.dart';
import 'package:agrisense/constants/predefined_prompt.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as path;
import 'package:uuid/uuid.dart';

/// Provider class for managing chat functionality.
class ChatProvider extends ChangeNotifier {
  /// List to store in-chat messages.
  final List<Message> _inChatMessages = [];

  /// Indicator for loading state.
  bool _isLoading = false;

  /// Model type
  static const String _modelType = 'gemini-2.0-flash';

  // Chat state
  String _currentChatId = '';
  bool _isFirstMessage = true;

  // Image state
  List<XFile>? _imagesFileList = [];
  int _currentIndex = 0;

  // Model instances
  GenerativeModel? _model;
  late final GenerativeModel _textModel;
  late final GenerativeModel _visionModel;

  // Page Controller
  final PageController _pageController = PageController();

  ChatProvider() {
    _textModel = GenerativeModel(
      model: _modelType,
      apiKey: ApiService.apiKey,
    );
    _visionModel = GenerativeModel(
      model: 'gemini-2.0-flash-vision',
      apiKey: ApiService.apiKey,
    );
  }

  // Getters
  List<Message> get inChatMessages => List.unmodifiable(_inChatMessages);
  bool get isLoading => _isLoading;
  String get currentChatId => _currentChatId;
  List<XFile>? get imagesFileList => _imagesFileList;
  int get currentIndex => _currentIndex;
  GenerativeModel? get model => _model;
  GenerativeModel? get textModel => _textModel;
  GenerativeModel? get visionModel => _visionModel;
  String get modelType => _modelType;
  PageController get pageController => _pageController;

  Future<void> setInChatMessages({required String chatId}) async {
    final messagesFromDB = await loadMessagesFromDB(chatId: chatId);
    for (var message in messagesFromDB) {
      if (!_inChatMessages.contains(message)) {
        _inChatMessages.add(message);
      }
    }
    notifyListeners();
  }

  Future<List<Message>> loadMessagesFromDB({required String chatId}) async {
    await Hive.openBox('${Constants.chatMessagesBox}$chatId');
    final messageBox = Hive.box('${Constants.chatMessagesBox}$chatId');

    return messageBox.keys.map((e) {
      final message = messageBox.get(e);
      return Message.fromMap(Map<String, dynamic>.from(message));
    }).toList();
  }

  /// Sets the list of image files for the chat.
  void setImagesFileList({required List<XFile> listValue}) {
    _imagesFileList = listValue;
  }

  /// Sets the current page index.
  void setCurrentIndex({required int newIndex}) {
    _currentIndex = newIndex;
  }

  /// Sets the current chat ID.
  void setCurrentChatId({required String newChatId}) {
    _currentChatId = newChatId;
    notifyListeners();
  }

  /// Sets the loading state.
  void setLoading({required bool value}) {
    _isLoading = value;
  }

  /// Configures the model based on whether the chat is text-only.
  Future<void> setModel({required bool isTextOnly}) async {
    if (_model == null) {
      _model = isTextOnly ? _textModel : _visionModel;
      notifyListeners();
    }
  }

  /// Deletes chat messages for a specified chat ID.
  Future<void> deleteChatMessages({required String chatId}) async {
    final boxName = '${Constants.chatMessagesBox}$chatId';
    if (!Hive.isBoxOpen(boxName)) {
      await Hive.openBox(boxName);
    }
    await Hive.box(boxName).clear();
    await Hive.box(boxName).close();

    if (_currentChatId.isNotEmpty && _currentChatId == chatId) {
      setCurrentChatId(newChatId: '');
      _inChatMessages.clear();
      notifyListeners();
    }
  }

  /// Prepares a chat room, loading messages if it's not a new chat.
  Future<void> prepareChatRoom({
    required bool isNewChat,
    required String chatID,
  }) async {
    if (!isNewChat) {
      final chatHistory = await loadMessagesFromDB(chatId: chatID);
      _inChatMessages
        ..clear()
        ..addAll(chatHistory);
    } else {
      _inChatMessages.clear();
    }
    setCurrentChatId(newChatId: chatID);
  }

  /// Sends a message and manages the response from the assistant.
  Future<void> sentMessage({
    required String message,
    required bool isTextOnly,
  }) async {
    await setModel(isTextOnly: isTextOnly);
    setLoading(value: true);
    final chatId = _currentChatId.isNotEmpty ? _currentChatId : getChatId();
    List<Content> history = await getHistory(chatId: chatId);

    // Send predefined prompt if it's the first message
    if (_isFirstMessage) {
      final promptContent = Content.text(predefinedPrompt);
      history = [promptContent, ...history];
      _isFirstMessage = false;
    }

    final imagesUrls = getImagesUrls(isTextOnly: isTextOnly);

    final messagesBox =
        await Hive.openBox('${Constants.chatMessagesBox}$chatId');
    final userMessageId = messagesBox.keys.length;
    final assistantMessageId = messagesBox.keys.length + 1;

    final userMessage = Message(
      messageId: userMessageId.toString(),
      chatId: chatId,
      role: Role.user,
      message: StringBuffer(message),
      imagesUrls: imagesUrls,
      timeSent: DateTime.now(),
    );

    _inChatMessages.add(userMessage);
    notifyListeners();

    if (_currentChatId.isEmpty) setCurrentChatId(newChatId: chatId);

    await sendMessageAndWaitForResponse(
      message: message,
      chatId: chatId,
      isTextOnly: isTextOnly,
      history: history,
      userMessage: userMessage,
      modelMessageId: assistantMessageId.toString(),
      messagesBox: messagesBox,
    );
  }

  /// Manages sending the message to the model and processes the streamed response.
  Future<void> sendMessageAndWaitForResponse({
    required String message,
    required String chatId,
    required bool isTextOnly,
    required List<Content> history,
    required Message userMessage,
    required String modelMessageId,
    required Box messagesBox,
  }) async {
    if (_model == null) {
      print('Model is null, cannot start chat session');
      return;
    }
    final chatSession = _model!.startChat(
      history: history.isEmpty || !isTextOnly ? null : history,
    );

    final content = await getContent(
      message: message,
      isTextOnly: isTextOnly,
    );

    final assistantMessage = userMessage.copyWith(
      messageId: modelMessageId,
      role: Role.assistant,
      message: StringBuffer(),
      timeSent: DateTime.now(),
    );

    _inChatMessages.add(assistantMessage);
    notifyListeners();

    chatSession.sendMessageStream(content).listen(
      (event) {
        _inChatMessages
            .firstWhere((element) =>
                element.messageId == assistantMessage.messageId &&
                element.role.name == Role.assistant.name)
            .message
            .write(event.text);
        print('event: ${event.text}');
        notifyListeners();
      },
      onDone: () async {
        print('stream done');
        await saveMessagesToDB(
          chatID: chatId,
          userMessage: userMessage,
          assistantMessage: assistantMessage,
          messagesBox: messagesBox,
        );
        setLoading(value: false);
        notifyListeners(); // Ensure listeners are notified after loading is set to false
      },
      onError: (error, stackTrace) {
        print('error: $error');
        setLoading(value: false);
        notifyListeners(); // Ensure listeners are notified after loading is set to false
      },
    );
  }

  /// Saves messages to the database.
  Future<void> saveMessagesToDB({
    required String chatID,
    required Message userMessage,
    required Message assistantMessage,
    required Box messagesBox,
  }) async {
    await messagesBox.add(userMessage.toMap());
    await messagesBox.add(assistantMessage.toMap());

    final chatHistoryBox = Boxes.getChatHistory();

    final chatHistory = ChatHistory(
      chatId: chatID,
      prompt: userMessage.message.toString(),
      response: assistantMessage.message.toString(),
      imagesUrls: userMessage.imagesUrls,
      timestamp: DateTime.now(),
    );
    await chatHistoryBox.put(chatID, chatHistory);
    await messagesBox.close();
  }

  /// Generates content based on message and images.
  Future<Content> getContent({
    required String message,
    required bool isTextOnly,
  }) async {
    if (isTextOnly) {
      return Content.text(message);
    } else {
      final imageFutures =
          _imagesFileList?.map((imageFile) => imageFile.readAsBytes());
      final imageBytes = await Future.wait(imageFutures!);
      final prompt = TextPart(message);
      final imageParts = imageBytes
          .map((bytes) => DataPart('image/jpeg', Uint8List.fromList(bytes)))
          .toList();

      return Content.multi([prompt, ...imageParts]);
    }
  }

  /// Retrieves image URLs.
  List<String> getImagesUrls({required bool isTextOnly}) {
    return !isTextOnly && _imagesFileList != null
        ? _imagesFileList!.map((image) => image.path).toList()
        : [];
  }

  /// Retrieves the chat history.
  Future<List<Content>> getHistory({required String chatId}) async {
    if (_currentChatId.isEmpty) return [];

    return _inChatMessages.map((message) {
      return message.role == Role.user
          ? Content.text(message.message.toString())
          : Content.model([TextPart(message.message.toString())]);
    }).toList();
  }

  /// Generates or retrieves the chat ID.
  String getChatId() {
    return _currentChatId.isNotEmpty ? _currentChatId : const Uuid().v4();
  }

  /// List available models, placeholder for API calls.
  Future<List<String>> listModels() async {
    await Future.delayed(const Duration(seconds: 1));
    return ['model1', 'model2', 'model3'];
  }

  /// Initializes Hive and registers required adapters.
  static Future<void> initHive() async {
    final dir = await path.getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    await Hive.initFlutter(Constants.geminiDB);

    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(ChatHistoryAdapter());
      await Hive.openBox<ChatHistory>(Constants.chatHistoryBox);
    }
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(UserModelAdapter());
      await Hive.openBox<UserModel>(Constants.userBox);
    }
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(SettingsAdapter());
      await Hive.openBox<Settings>(Constants.settingsBox);
    }
  }
}
