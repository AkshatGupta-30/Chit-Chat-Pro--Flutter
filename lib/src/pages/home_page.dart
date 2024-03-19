import 'package:chit_chat_pro/src/controllers/chat_controller.dart';
import 'package:chit_chat_pro/src/pages/main_view.dart';
import 'package:chit_chat_pro/src/pages/bottom_view.dart';
import 'package:circular_countdown/circular_countdown.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: ChatController(),
      builder: (controller) {
        return Scaffold(
          appBar: _appBar(controller, context),
          body: _body(controller),
        );
      }
    );
  }

  AppBar _appBar(ChatController controller, BuildContext context) {
    return AppBar(
      title: Text('Chit Chat Pro'),
      actions: [
        Obx(() => CircularCountdown(
          diameter: 30, gapFactor: 3,
          countdownTotal: 21, countdownRemaining: controller.countdown.value,
          countdownTotalColor: Colors.grey, countdownCurrentColor: Colors.orangeAccent,
          countdownRemainingColor: Colors.red, textStyle: Theme.of(context).primaryTextTheme.bodySmall,
        )),
        Gap(10)
      ],
    );
  }

  Container _body(ChatController controller) {
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
}