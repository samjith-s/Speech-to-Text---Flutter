import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class DisplaySpeechDialog extends StatefulWidget {
  final ValueChanged<String> onTextConfirmed;

  const DisplaySpeechDialog({
    super.key,
    required this.onTextConfirmed,
  });

  @override
  State<DisplaySpeechDialog> createState() => _DisplaySpeechDialogState();
}

class _DisplaySpeechDialogState extends State<DisplaySpeechDialog> {
  late SpeechToText _speechToText;
  bool _speechEnabled = false;
  String _lastWords = '';

  @override
  void initState() {
    super.initState();
    _speechToText = SpeechToText();
    _initSpeech().then((value) {
      _startListening();
    });
  }

  Future<void> _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  Future<void> _startListening() async {
    await _speechToText.listen(
      onResult: _onSpeechResult,
      listenFor: const Duration(minutes: 3), // Set a longer duration
      pauseFor: const Duration(seconds: 10),
    );
  }

  Future<void> _stopListening() async {
    await _speechToText.stop();
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
    });
  }

  @override
  void dispose() {
    _speechToText.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_speechToText.isListening) const Text("Listening....."),
          const SizedBox(height: 20.0),
          Text(
            _speechEnabled ? _lastWords : "Please allow the permissions to use the microphone",
          ),
          const SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: _lastWords.trim().isNotEmpty
                ? () async {
                    await _stopListening();
                    widget.onTextConfirmed(_lastWords);
                    if (mounted) {
                      Navigator.of(context).pop();
                    }
                  }
                : null,
            child: const Text("Confirm"),
          )
        ],
      ),
    );
  }
}
