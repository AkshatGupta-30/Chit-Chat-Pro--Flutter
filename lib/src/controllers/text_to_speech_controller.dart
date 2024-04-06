import 'dart:io';

import 'package:chit_chat_pro/src/controllers/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';

class TTSController extends GetxController {
  final int index;
  TTSController(this.index);

  final _chatController = Get.find<ChatController>();
  FlutterTts flutterTts = FlutterTts();
  String _text = '';

  final double _volume = 1; //? Range: 0-1
  final rate = 1.0.obs;
  final double _pitch = 1.0; //? Range: 0-2

  final isPlaying = false.obs;
  final canStopped = false.obs;

  List<DropdownMenuItem<double>> get dropdownItems{
    List<DropdownMenuItem<double>> menuItems = [
      const DropdownMenuItem(value: 0.25, child: Text('0.25x', style: TextStyle(color: Colors.white),)),
      const DropdownMenuItem(value: 0.5, child: Text('0.5x', style: TextStyle(color: Colors.white),)),
      const DropdownMenuItem(value: 0.75, child: Text('0.75x', style: TextStyle(color: Colors.white),)),
      const DropdownMenuItem(value: 1, child: Text('1x', style: TextStyle(color: Colors.white),)),
      const DropdownMenuItem(value: 1.25, child: Text('1.25x', style: TextStyle(color: Colors.white),)),
      const DropdownMenuItem(value: 1.5, child: Text('1.5x', style: TextStyle(color: Colors.white),)),
      const DropdownMenuItem(value: 1.75, child: Text('1.75x', style: TextStyle(color: Colors.white),)),
      const DropdownMenuItem(value: 2, child: Text('2x', style: TextStyle(color: Colors.white),)),
    ];
    return menuItems;
  }

  @override
  void onInit() {
    super.onInit();
    initDetail();
    initTTS();
  }

  void initDetail() => _text = _chatController.contents[index].content;

  Future<void> initTTS() async {
    _setAwaitOptions();
    if (Platform.isAndroid) {
      _getDefaultEngine();
      _getDefaultVoice();
    }
    _configureTTS();

    await flutterTts.setEngine('com.google.android.tts');
    await flutterTts.setLanguage('en-IN');

    flutterTts.setStartHandler(() {
      isPlaying.value = true;
      canStopped.value = true;
    });

    flutterTts.setPauseHandler(() {
      isPlaying.value = false;
      canStopped.value = true;
    });

    flutterTts.setContinueHandler(() {
      isPlaying.value = true;
      canStopped.value = true;
    });

    flutterTts.setCancelHandler(() {
      isPlaying.value = false;
      canStopped.value = false;
    });

    flutterTts.setCompletionHandler(() {
      canStopped.value = false;
      isPlaying.value = false;
    });

    flutterTts.setErrorHandler((msg) {
      "error: $msg".printError();
    });
  }

  Future<void> _setAwaitOptions() async => await flutterTts.awaitSpeakCompletion(true);

  Future<void> _getDefaultEngine() async => await flutterTts.getDefaultEngine;

  Future<void> _getDefaultVoice() async => await flutterTts.getDefaultVoice;

  Future<void> changeRate(double newValue) async {
    rate.value = newValue;
    await flutterTts.setSpeechRate(newValue);
  }

  Future<void> _configureTTS() async {
    await flutterTts.setVolume(_volume);
    await flutterTts.setSpeechRate(rate.value);
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