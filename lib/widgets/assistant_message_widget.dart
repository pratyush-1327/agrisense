import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:agrisense/models/message.dart';
import 'package:agrisense/widgets/preview_images_widget.dart';

/// A widget that displays a message from the assistant.
///
/// This widget renders the assistant's message with appropriate styling,
/// including any attached images. It also shows a loading animation
/// when the message is empty (during typing).
class AssistantMessageWidget extends StatelessWidget {
  /// Creates an assistant message widget.
  ///
  /// The [message] parameter contains the message content and any images to display.
  const AssistantMessageWidget({
    super.key,
    required this.message,
  });

  /// The message to be displayed.
  final Message message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.9,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(18),
        ),
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.only(bottom: 8),
        child: message.message.toString().isEmpty
            ? const SizedBox(
                width: 50,
                child: SpinKitThreeBounce(
                  color: Colors.blueGrey,
                  size: 20.0,
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (message.imagesUrls.isNotEmpty)
                    PreviewImagesWidget(
                      message: message,
                    ),
                  MarkdownBody(
                    selectable: true,
                    data: message.message.toString(),
                  ),
                ],
              ),
      ),
    );
  }
}
