import 'package:chit_chat_pro/src/controllers/chat_controller.dart';
import 'package:chit_chat_pro/src/controllers/image_to_text_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PromptField extends StatelessWidget {
  PromptField({super.key});

  final chatController = Get.find<ChatController>();
  final controller = Get.find<ImageToTextController>();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: chatController.textController, focusNode: chatController.focusNode,
      textInputAction: TextInputAction.newline, keyboardType: TextInputType.multiline,
      minLines: 1, maxLines: 6,
      style: Theme.of(context).primaryTextTheme.bodyLarge,
      decoration: InputDecoration(
        hintText: "Share your thoughts with us.",
        suffixIcon: CloseButton(onPressed: () => chatController.textController.clear()),
      ),
      onTapOutside: (event) => chatController.focusNode.unfocus(),
    );
  }
}
