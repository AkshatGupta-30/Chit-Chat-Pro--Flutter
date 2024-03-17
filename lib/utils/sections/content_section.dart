import 'package:chit_chat_pro/src/model/message.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ContentSection extends StatelessWidget {
  final Message gptMessage;
  ContentSection(this.gptMessage, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            CircleAvatar(radius: 15, backgroundColor: Colors.yellowAccent,),
            Gap(5),
            Container(
              height: 30, padding: EdgeInsets.symmetric(horizontal: 5), alignment: Alignment.center,
              child: Text('Chit Chat Pro', style: Theme.of(context).primaryTextTheme.headlineSmall!.copyWith(
                fontWeight: FontWeight.w800, fontSize: 21
              ))
            )
          ]
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(width: 30,),
            Gap(5),
            Expanded(child: Text(gptMessage.content, style: Theme.of(context).primaryTextTheme.bodyLarge,))
          ]
        )
      ],
    );
  }
}