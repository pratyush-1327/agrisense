import 'package:flutter/material.dart';
import 'package:agrisense/models/message.dart';
import 'package:agrisense/providers/chat_provider.dart';
import 'package:agrisense/widgets/assistant_message_widget.dart';
import 'package:agrisense/widgets/my_message_widget.dart';

/// A widget that displays a conversation between the user and the assistant.
///
/// This widget renders a list of chat messages, differentiating between
/// user messages and assistant messages with appropriate styling.
class ChatMessages extends StatelessWidget {
  /// Creates a chat messages widget.
  ///
  /// The [scrollController] controls the scrolling of the chat list.
  /// The [chatProvider] provides the messages to be displayed.
  const ChatMessages({
    super.key,
    required this.scrollController,
    required this.chatProvider,
  });

  /// Controls scrolling behavior of the chat messages list.
  final ScrollController scrollController;

  /// Provides access to the chat messages and related functionality.
  final ChatProvider chatProvider;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      itemCount: chatProvider.inChatMessages.length,
      itemBuilder: (context, index) {
        final message = chatProvider.inChatMessages[index];
        return message.role == Role.user
            ? MyMessageWidget(message: message)
            : AssistantMessageWidget(message: message);
      },
    );
  }
}
