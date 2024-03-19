import 'package:chit_chat_pro/src/controllers/chat_controller.dart';
import 'package:chit_chat_pro/src/controllers/prompt_content_controller.dart';
import 'package:chit_chat_pro/utils/sections/content_section.dart';
import 'package:chit_chat_pro/utils/sections/prompt_section.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class PromptContentSection extends StatelessWidget {
  final int index;
  PromptContentSection(this.index, {super.key});

  final controller = Get.find<ChatController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      global: false,
      init: PCController(index),
      builder: (controller) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Color(0xFF212529),
            border: Border.all(color: Colors.white24),
            borderRadius: BorderRadius.circular(20)
          ),
          child: Column(
            children: [PromptSection(index, controller), Gap(7), Divider(color: Colors.white54,), Gap(7), ContentSection(index)],
          )
        );
      }
    );
  }
}