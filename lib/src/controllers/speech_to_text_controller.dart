import 'package:chit_chat_pro/src/controllers/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechToTextController extends GetxController {
  final speechToText = SpeechToText();
  final _chatController = Get.find<ChatController>();
  final speechEnabled = false.obs;
  final _previousText = ''.obs;
  final lastWords = ''.obs;
  final listening = false.obs;

  @override
  void onInit() {
    super.onInit();
    _initSpeech();
  }

  Future<void> _initSpeech() async {
    speechEnabled.value = await speechToText.initialize(onStatus: (status) {
      if(status == 'listening') listening.value = true;
      else listening.value = false;
    });
  }

  void startListening(BuildContext context) async {
    _previousText.value = _chatController.textController.text;
    if(!speechEnabled.value) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('You need to enable Micophone and Nearby Device permisiion to enable Speech to text feature'))
      );
    } else {
      await speechToText.listen(onResult: _onSpeechResult);
    }
  }

  void stopListening() async => await speechToText.stop();

  void _onSpeechResult(SpeechRecognitionResult result) {
    lastWords.value = result.toFinal().recognizedWords;
    _chatController.textController.text = (_previousText.value.isEmpty) ? lastWords.value : '${_previousText.value} ${lastWords.value}';
  }
}