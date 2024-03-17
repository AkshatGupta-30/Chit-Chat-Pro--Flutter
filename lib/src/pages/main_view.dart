import 'package:chit_chat_pro/src/controllers/chat_controller.dart';
import 'package:chit_chat_pro/src/model/message.dart';
import 'package:chit_chat_pro/utils/sections/prompt_content_section.dart';
import 'package:flutter/material.dart';

class PromptView extends StatelessWidget {
  final ChatController controller;
  PromptView(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView.builder(
        itemCount: controller.chat.length,
        itemBuilder: (context, index) {
          Message message = controller.chat[index].message;
          return PromptContentSection(message);
        },
      ),
    );
  }
}