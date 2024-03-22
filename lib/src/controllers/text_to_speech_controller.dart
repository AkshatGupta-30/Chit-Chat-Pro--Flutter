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

  final double _volume = 1; //? Range: 0-1
  final double _rate = 1; //? Range: 0-2
  final double _pitch = 1.0; //? Range: 0-2
  bool isCurrentLanguageInstalled = false;

  final isPlaying = false.obs;
  final isStopped = true.obs;

  @override
  void onInit() {
    super.onInit();
    initDetail();
    initTts();
  }

  void initDetail() => _text = chatController.contents[index].content;

  Future<void> initTts() async {
    flutterTts = FlutterTts();

    _setAwaitOptions();
    if (Platform.isAndroid) {
      _getDefaultEngine();
      _getDefaultVoice();
    }
    _configureTTS();

    await flutterTts.setEngine('com.google.android.tts');
    await flutterTts.setLanguage('en-IN');

    flutterTts.setCompletionHandler(() {
      "Complete".printInfo();
      isStopped.value = true;
      isPlaying.value = false;
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
    isStopped.value = true;
  });

  void playPauseTapped() async {
    if(isPlaying.value) {
      await pause().then((value) => isPlaying.value = false);
    } else {
      isPlaying.value = true;
      isStopped.value = false;
      await speak();
    }
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }
}