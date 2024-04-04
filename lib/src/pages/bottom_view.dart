import 'package:chit_chat_pro/src/controllers/chat_controller.dart';
import 'package:chit_chat_pro/utils/widgets/image_button.dart';
import 'package:chit_chat_pro/utils/widgets/image_view.dart';
import 'package:chit_chat_pro/utils/widgets/mic_button.dart';
import 'package:chit_chat_pro/utils/widgets/prompt_field.dart';
import 'package:chit_chat_pro/utils/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class BottomView extends StatelessWidget {
  BottomView({super.key});

  final controller = Get.find<ChatController>();

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.sizeOf(context);
    return Container(
      width: media.width,
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ImageView(), PromptField(), Gap(10),
          Row(children: [SubmitButtton(), Gap(5), ImageButton(), Gap(5), MicButton()]),
          Gap(10),
          Container(
            width: double.maxFinite, alignment: Alignment.center,
            child: Text(
              "Chit Chat Pro, Enhanced with ChatGPT Brilliance.",
              style: Theme.of(context).primaryTextTheme.bodySmall,
            ),
          )
        ],
      ),
    );
  }
}
