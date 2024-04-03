import 'dart:io';

import 'package:chit_chat_pro/src/controllers/chat_controller.dart';
import 'package:chit_chat_pro/src/controllers/image_to_text_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter/iconify.dart';

class PromptField extends StatelessWidget {
  PromptField({super.key});

  final chatController = Get.find<ChatController>();
  final controller = Get.find<ImageToTextController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => TextField(
      controller: chatController.textController, focusNode: chatController.focusNode,
      textInputAction: TextInputAction.newline, keyboardType: TextInputType.multiline,
      minLines: 1, maxLines: 6,
      style: Theme.of(context).primaryTextTheme.bodyLarge,
      decoration: InputDecoration(
        hintText: "Share your thoughts with us.",
        suffixIcon: CloseButton(onPressed: () => chatController.textController.clear()),
        icon: (controller.imageFile.value.path.isEmpty) ? null : _displayImage()
      ),
      onTapOutside: (event) => chatController.focusNode.unfocus(),
    ));
  }

  Stack _displayImage() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.file(File(controller.imageFile.value.path), width: 50, height: 50, fit: BoxFit.cover,)
        ),
        Positioned(
          top: 0, right: 0,
          child: GestureDetector(
            onTap: controller.removeImage,
            child: CircleAvatar(
              radius: 10, backgroundColor: Colors.grey.shade700.withOpacity(0.75),
              child: Iconify(Ic.baseline_close, size: 15, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
