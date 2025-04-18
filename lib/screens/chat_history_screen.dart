import 'package:flutter/material.dart';
import 'package:agrisense/hive/boxes.dart';
import 'package:agrisense/hive/chat_history.dart';
import 'package:agrisense/widgets/chat_history_widget.dart';
import 'package:agrisense/widgets/empty_history_widget.dart';
import 'package:easy_localization/easy_localization.dart'; // Import easy_localization
import 'package:hive_flutter/hive_flutter.dart';

class ChatHistoryScreen extends StatefulWidget {
  const ChatHistoryScreen({super.key});

  @override
  State<ChatHistoryScreen> createState() => _ChatHistoryScreenState();
}

class _ChatHistoryScreenState extends State<ChatHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        centerTitle: true,
        title: Text('chatHistoryTitle'.tr()), // Translate
      ),
      body: ValueListenableBuilder<Box<ChatHistory>>(
        valueListenable: Boxes.getChatHistory().listenable(),
        builder: (context, box, _) {
          final chatHistory =
              box.values.toList().cast<ChatHistory>().reversed.toList();
          return chatHistory.isEmpty
              ? const EmptyHistoryWidget()
              : Stack(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount: chatHistory.length,
                      itemBuilder: (context, index) {
                        final chat = chatHistory[index];
                        return ChatHistoryWidget(chat: chat);
                      },
                    ),
                  ),
                  Positioned(
                    right: -190,
                    bottom: -70,
                    child: Container(
                        height: 500,
                        child: Image.asset(
                          'assets/images/splant.png',
                          fit: BoxFit.fill,
                        )),
                  )
                ]);
        },
      ),
    );
  }
}
