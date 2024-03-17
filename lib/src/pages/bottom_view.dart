import 'package:chit_chat_pro/src/controllers/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/material_symbols.dart';

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
            decoration: InputDecoration(
              hintText: "Share your thoughts with us.",
              suffixIcon: CloseButton(onPressed: () => controller.textController.text = '',)
            ),
          ),
          Gap(10),
          ElevatedButton(
            onPressed: (controller.isMainChat.value)
              ? () {
                if(controller.textController.text.isNotEmpty) {
                  // TODO - Api Call
                } else {
                  "Empty Text".printError();
                }
              }
              : null,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Submit', style: Theme.of(context).primaryTextTheme.headlineSmall,),
                Gap(2),
                Iconify(MaterialSymbols.send_rounded, size: 32, color: Colors.white,)
              ],
            ),
          ),
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
