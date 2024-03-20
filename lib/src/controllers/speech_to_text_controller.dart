import 'package:chit_chat_pro/src/controllers/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechToTextController extends GetxController {
  final speechToText = SpeechToText().obs;
  final _chatController = Get.find<ChatController>();
  final speechEnabled = false.obs;
  final lastWords = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _initSpeech();
  }

  Future<void> _initSpeech() async => speechEnabled.value = await speechToText.value.initialize();

  void startListening(BuildContext context) async {
    if(!speechEnabled.value) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('You need to enable Micophone and Nearby Device permisiion to enable Speech to text feature'))
      );
    } else {
      await speechToText.value.listen(onResult: _onSpeechResult);
    }
    update();
  }

  void stopListening() async {
    await speechToText.value.stop();
    update();
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    lastWords.value = result.recognizedWords;
    _chatController.textController.text += (_chatController.textController.text.isEmpty) ? lastWords.value : ' ${lastWords.value}';
  }
}