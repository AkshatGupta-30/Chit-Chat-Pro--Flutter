import 'package:chit_chat_pro/src/controllers/chat_controller.dart';
import 'package:chit_chat_pro/src/controllers/image_to_text_controller.dart';
import 'package:chit_chat_pro/src/controllers/speech_to_text_controller.dart';
import 'package:chit_chat_pro/src/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SplashController extends GetxController with GetSingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> scaleAnimation;
  
  @override
  void onInit() {
    super.onInit();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 750));
    scaleAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
    initSetup();
  }
  
  Future<void> initSetup() async {
    await setupServiceLocator();
    Future.delayed(const Duration(milliseconds: 1500), () async => Get.off(() => const HomePage()));
  }

  Future<void> setupServiceLocator() async {
    Get.put(ChatController());
    Get.put(ImageToTextController());
    Get.put(SpeechToTextController());
  }

  @override
  void onClose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    _controller.dispose();
    super.onClose();
  }
}