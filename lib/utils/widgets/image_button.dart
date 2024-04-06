import 'package:chit_chat_pro/src/controllers/chat_controller.dart';
import 'package:chit_chat_pro/src/controllers/image_to_text_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter/iconify.dart';

class ImageButton extends StatelessWidget {
  ImageButton({super.key});

  final controller = Get.find<ImageToTextController>();
  final chatController = Get.find<ChatController>();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => controller.getImage(context),
      borderRadius: BorderRadius.circular(45),
      child: Container(
        width: 45, height: 45, alignment: Alignment.center,
        decoration: BoxDecoration(color: const Color(0xFF2d6a4f), borderRadius: BorderRadius.circular(45)),
        child: const Iconify(Bx.image_add, size: 24, color: Colors.white,)
      ),
    );
  }
}
