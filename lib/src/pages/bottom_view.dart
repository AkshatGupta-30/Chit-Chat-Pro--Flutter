import 'package:chit_chat_pro/src/controllers/chat_controller.dart';
import 'package:chit_chat_pro/utils/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class BottomView extends StatelessWidget {
  final ChatController controller;
  BottomView(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          TextField(
            controller: controller.textController,
            focusNode: controller.focusNode,
            textInputAction: TextInputAction.newline,
            keyboardType: TextInputType.multiline,
            minLines: 1, maxLines: 6,
            style: Theme.of(context).primaryTextTheme.bodyLarge,
            decoration: InputDecoration(
              hintText: "Share your thoughts with us.",
              suffixIcon: CloseButton(onPressed: () => controller.textController.clear(),)
            ),
            onTapOutside: (event) => controller.focusNode.unfocus(),
          ),
          Gap(10),
          SubmitButtton(controller: controller),
          Gap(10),
          Text(
            "Chit Chat Pro, Enhanced with ChatGPT Brilliance.",
            style: Theme.of(context).primaryTextTheme.bodySmall,
          )
        ],
      ),
    );
  }
}
