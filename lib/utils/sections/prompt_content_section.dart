import 'package:chit_chat_pro/src/controllers/chat_controller.dart';
import 'package:chit_chat_pro/src/controllers/prompt_content_controller.dart';
import 'package:chit_chat_pro/utils/sections/content_section.dart';
import 'package:chit_chat_pro/utils/sections/prompt_section.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:super_string/super_string.dart';

class PromptContentSection extends StatelessWidget {
  final int index;
  PromptContentSection(this.index, {super.key});

  final chatController = Get.find<ChatController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      global: false,
      init: PCController(index),
      builder: (controller) {
        return GestureDetector(
          onDoubleTap: () => (index < chatController.contents.length) ? chatController.showDetailDialog(context, index) : null,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Color(0xFF212529),
              border: Border.all(color: Colors.white24),
              borderRadius: BorderRadius.circular(20)
            ),
            child: Column(
              children: [
                PromptSection(index, controller),
                Gap(7), Divider(color: Colors.white54,), Gap(7),
                ContentSection(index),
                FinishReasonSection(index),
              ],
            )
          ),
        );
      }
    );
  }
}

class FinishReasonSection extends StatelessWidget {
  final int index;
  FinishReasonSection(this.index, {super.key});

  final chatController = Get.find<ChatController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if(chatController.contents.length == index) return SizedBox();
      return Container(
        height: 20, alignment: Alignment.centerRight,
        child: Text(
          'Finish Reason: ${chatController.finishReasons[index].toStr.title()}',
          style: TextStyle(color: Colors.grey, fontSize: 12),
        ),
      );
    });
  }
}