import 'package:chit_chat_pro/src/controllers/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PromptField extends StatelessWidget {
  PromptField({super.key});

  final controller = Get.find<ChatController>();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller.textController, focusNode: controller.focusNode,
      textInputAction: TextInputAction.newline, keyboardType: TextInputType.multiline,
      minLines: 1, maxLines: 6, style: Theme.of(context).primaryTextTheme.bodyLarge,
      decoration: InputDecoration(
        hintText: "Share your thoughts with us.",
        suffixIcon: CloseButton(onPressed: () => controller.textController.clear(),)
      ),
      onTapOutside: (event) => controller.focusNode.unfocus(),
    );
  }
}
