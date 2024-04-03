import 'package:chit_chat_pro/src/controllers/chat_controller.dart';
import 'package:chit_chat_pro/src/controllers/speech_to_text_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter/iconify.dart';

class MicButton extends StatelessWidget {
  MicButton({super.key});

  final controller = Get.find<SpeechToTextController>();
  final chatController = Get.find<ChatController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => InkWell(
      onTap: () => controller.speechToText.value.isNotListening ? controller.startListening(context) : controller.stopListening(),
      borderRadius: BorderRadius.circular(45),
      child: Container(
        width: 45, height: 45, alignment: Alignment.center,
        decoration: BoxDecoration(color: Color(0xFF2d6a4f), borderRadius: BorderRadius.circular(45)),
        child: (controller.speechToText.value.isNotListening)
            ? Iconify(Fa6Solid.microphone_lines, size: 24, color: Colors.white,)
            : SpinKitWave(color: Colors.white, size: 24, itemCount: 12, type: SpinKitWaveType.center,),
      ),
    ));
  }
}
