import 'package:chit_chat_pro/utils/sections/prompt_content_section.dart';
import 'package:flutter/material.dart';

class PromptView extends StatelessWidget {
  PromptView({super.key});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView( // TODO - Convert to builder
        children: [
          PromptContentSection(),
          PromptContentSection(),
        ],
      ),
    );
  }
}