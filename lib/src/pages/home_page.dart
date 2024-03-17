import 'package:chit_chat_pro/src/pages/main_view.dart';
import 'package:chit_chat_pro/src/pages/bottom_view.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chit Chat Pro'),),
      body: Container(
        padding: EdgeInsets.only(top: 6),
        child: Column(
          children: [
            PromptView(),
            Gap(20),
            BottomView()
          ],
        ),
      ),
    );
  }
}