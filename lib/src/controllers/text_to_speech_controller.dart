import 'dart:io';

import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter_tts/flutter_tts_web.dart';
import 'package:get/get.dart';

class TextToSpeechController extends GetxController {
  late FlutterTts flutterTts;
  TtsState ttsState = TtsState.stopped;
  
  @override
  void onInit() {
    super.onInit();
    initTts();
  }
  
  void initTts() async {
    flutterTts = FlutterTts();
    _setAwaitOptions();
    if (Platform.isAndroid) {
      await flutterTts.getDefaultEngine;
      await flutterTts.getDefaultVoice;
    }

    flutterTts.setStartHandler(() {
      "Playing".printInfo();
      ttsState = TtsState.playing;
    });

    flutterTts.setCompletionHandler(() {
      "Complete".printInfo();
      ttsState = TtsState.stopped;
    });

    flutterTts.setCancelHandler(() {
      "Cancel".printInfo();
      ttsState = TtsState.stopped;
    });

    flutterTts.setPauseHandler(() {
      "Paused".printInfo();
      ttsState = TtsState.paused;
    });

    flutterTts.setContinueHandler(() {
      "Continued".printInfo();
      ttsState = TtsState.continued;
    });

    flutterTts.setErrorHandler((msg) {
      "error: $msg".printInfo();
      ttsState = TtsState.stopped;
    });
  }

  Future _setAwaitOptions() async => await flutterTts.awaitSpeakCompletion(true);
}