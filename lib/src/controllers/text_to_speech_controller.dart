import 'dart:io';

import 'package:chit_chat_pro/src/controllers/chat_controller.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';

class TTSController extends GetxController {
  final int index;
  TTSController(this.index);

  final chatController = Get.find<ChatController>();
  FlutterTts flutterTts = FlutterTts();
  String _text = '';
  late Rx<int?> currentWordStart = 0.obs;
  late Rx<int?> currentWordEnd = 0.obs;

  final double _volume = 1; //? Range: 0-1
  final double _rate = 1; //? Range: 0-2
  final double _pitch = 1.0; //? Range: 0-2

  final isPlaying = false.obs;
  final canStopped = false.obs;

  @override
  void onInit() {
    super.onInit();
    initDetail();
    initTTS();
  }

  void initDetail() {
    _text = chatController.contents[index].content;
  }

  Future<void> initTTS() async {
    _setAwaitOptions();
    if (Platform.isAndroid) {
      _getDefaultEngine();
      _getDefaultVoice();
    }
    _configureTTS();

    await flutterTts.setEngine('com.google.android.tts');
    await flutterTts.setLanguage('en-IN');

    flutterTts.setProgressHandler((text, start, end, word) {
      currentWordStart.value = start;
      currentWordEnd.value = end;
      update();
    });

    flutterTts.setStartHandler(() {
      isPlaying.value = true;
      canStopped.value = true;
      update();
    });

    flutterTts.setPauseHandler(() {
      isPlaying.value = false;
      canStopped.value = true;
      update();
    });

    flutterTts.setContinueHandler(() {
      isPlaying.value = true;
      canStopped.value = true;
      update();
    });

    flutterTts.setCancelHandler(() {
      isPlaying.value = false;
      canStopped.value = false;

      currentWordStart.value = 0;
      currentWordEnd.value = 0;
      update();
    });

    flutterTts.setCompletionHandler(() {
      canStopped.value = false;
      isPlaying.value = false;

      currentWordStart.value = 0;
      currentWordEnd.value = 0;
      update();
    });

    flutterTts.setErrorHandler((msg) {
      "error: $msg".printError();
    });
  }

  Future<void> _setAwaitOptions() async => await flutterTts.awaitSpeakCompletion(true);

  Future<void> _getDefaultEngine() async => await flutterTts.getDefaultEngine;

  Future<void> _getDefaultVoice() async => await flutterTts.getDefaultVoice;

  Future<void> _configureTTS() async {
    await flutterTts.setVolume(_volume);
    await flutterTts.setSpeechRate(_rate);
    await flutterTts.setPitch(_pitch);
  }

  Future<void> speak() async => await flutterTts.speak(_text);
  Future<void> pause() async => await flutterTts.pause();
  Future<void> stop() async => await flutterTts.stop().then((value) {
    isPlaying.value = false;
    canStopped.value = false;
  });

  void playPauseTapped() async {
    if(isPlaying.value) {
      await pause().then((value) => isPlaying.value = false);
    } else {
      isPlaying.value = true;
      canStopped.value = true;
      await speak();
    }
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }
}