import 'package:chit_chat_pro/src/controllers/chat_controller.dart';
import 'package:chit_chat_pro/src/pages/main_view.dart';
import 'package:chit_chat_pro/src/pages/bottom_view.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chit Chat Pro'),),
      body: GetBuilder(
        init: ChatController(),
        builder: (controller) {
          return Container(
            padding: EdgeInsets.only(top: 6),
            child: Column(
              children: [
                PromptView(controller),
                Gap(20),
                BottomView(controller)
              ],
            ),
          );
        }
      ),
    );
  }
}