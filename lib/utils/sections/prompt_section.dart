import 'package:chit_chat_pro/src/model/message.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class PromptSection extends StatelessWidget {
  final Message userPrompt;
  PromptSection(this.userPrompt, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            CircleAvatar(radius: 15, backgroundColor: Colors.purpleAccent,), Gap(5),
            Container(
              height: 30, padding: EdgeInsets.symmetric(horizontal: 5), alignment: Alignment.center,
              child: Text('You', style: Theme.of(context).primaryTextTheme.headlineSmall!.copyWith(
                fontWeight: FontWeight.w800, fontSize: 22
              ))
            )
          ]
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(width: 30,), Gap(5),
            Expanded(child: Text(userPrompt.content, style: Theme.of(context).primaryTextTheme.bodyLarge,))
          ]
        )
      ],
    );
  }
}
