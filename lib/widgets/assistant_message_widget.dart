import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:agrisense/models/message.dart';
import 'package:agrisense/widgets/preview_images_widget.dart';
import 'package:flutter_tts/flutter_tts.dart'; // Import flutter_tts
import 'package:connectivity_plus/connectivity_plus.dart';

class AssistantMessageWidget extends StatefulWidget {
  const AssistantMessageWidget({
    super.key,
    required this.message,
  });

  /// The message to be displayed.
  final Message message;

  @override
  State<AssistantMessageWidget> createState() => _AssistantMessageWidgetState();
}

class _AssistantMessageWidgetState extends State<AssistantMessageWidget> {
  late FlutterTts flutterTts;

  @override
  void initState() {
    super.initState();
    flutterTts = FlutterTts();
    _setupTts();
  }

  void _setupTts() async {
    // Set language (try "en-IN" or "en-US")
    try {
      await flutterTts.setLanguage("en-US");
      print("TTS language set to en-US");
    } catch (e) {
      print("Error setting TTS language to en-IN, trying en-US: $e");
      try {
        await flutterTts.setLanguage("en-IN");
        print("TTS language set to en-IN");
      } catch (e2) {
        print("Error setting TTS language to en-US: $e2");
      }
    }

    // Optional: Configure other settings if needed
    // await flutterTts.setSpeechRate(0.5);
    // await flutterTts.setVolume(1.0);
    // await flutterTts.setPitch(1.0);

    // Add event handlers for more detailed logging
    flutterTts.setStartHandler(() {
      print("TTS Started");
    });

    flutterTts.setCompletionHandler(() {
      print("TTS Completed");
    });

    flutterTts.setErrorHandler((msg) {
      print("TTS Error: $msg");
    });

    flutterTts.setCancelHandler(() {
      print("TTS Cancelled");
    });

    // For Android specific settings (might help)
    await flutterTts.awaitSpeakCompletion(true); // Enabled this setting
  }

  @override
  void dispose() {
    flutterTts.stop(); // Stop TTS when widget is disposed
    // Clear handlers with empty closures to avoid type errors
    flutterTts.setStartHandler(() {});
    flutterTts.setCompletionHandler(() {});
    flutterTts.setErrorHandler((dynamic msg) {
      print("TTS Error: $msg");
    });
    flutterTts.setCancelHandler(() {});
    super.dispose();
  }

  Future<void> _speak(String text) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      print("No network connection available. Skipping TTS.");
      // Optionally, display a message to the user.
      return;
    }

    const maxRetries = 3;
    int retries = 0;

    while (retries < maxRetries) {
      print(
          "Attempting to speak: '$text' (Attempt ${retries + 1})"); // Added log
      try {
        final result = await flutterTts.speak(text);
        if (result == 1) {
          print("TTS speak call successful"); // Added log
          return;
        } else {
          print("TTS speak call failed (result code: $result)"); // Added log
        }
      } catch (e) {
        print("Error calling flutterTts.speak: $e"); // Added log for errors
      }

      retries++;
      await Future.delayed(const Duration(seconds: 1)); // Wait before retrying
    }

    print("TTS failed after $maxRetries attempts.");
  }

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
        child: widget.message.message.toString().isEmpty
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
                  if (widget.message.imagesUrls.isNotEmpty)
                    PreviewImagesWidget(
                      message: widget.message,
                    ),
                  MarkdownBody(
                    selectable: true,
                    data: widget.message.message.toString(),
                  ),
                  // Add the play button icon here
                  IconButton(
                    icon: const Icon(Icons.play_arrow),
                    onPressed: () {
                      // Speak the message text
                      _speak(widget.message.message.toString());
                    },
                    tooltip: 'Play message audio', // Optional: Add tooltip
                  ),
                ],
              ),
      ),
    );
  }
}
