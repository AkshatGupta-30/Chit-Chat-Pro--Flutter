import 'package:chit_chat_pro/src/model/message.dart';
import 'package:chit_chat_pro/utils/sections/content_section.dart';
import 'package:chit_chat_pro/utils/sections/prompt_section.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class PromptContentSection extends StatelessWidget {
  final Message gptMessage;
  PromptContentSection(this.gptMessage, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color(0xFF212529),
        border: Border.all(color: Colors.white24),
        borderRadius: BorderRadius.circular(20)
      ),
      child: Column(
        children: [
          PromptSection(),
          Gap(7), Divider(color: Colors.white54,), Gap(7),
          ContentSection(gptMessage)
        ],
      )
    );
  }
}