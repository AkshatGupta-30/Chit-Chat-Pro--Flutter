import 'package:chit_chat_pro/src/controllers/chat_controller.dart';
import 'package:chit_chat_pro/utils/sections/prompt_content_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PromptView extends StatelessWidget {
  final ChatController controller;
  PromptView(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Obx(() => ListView.builder(
        itemCount: controller.contents.length,
        itemBuilder: (context, index) {
          return PromptContentSection(controller, index);
        },
      ),
    ));
  }
}