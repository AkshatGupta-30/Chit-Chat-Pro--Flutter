import 'package:chit_chat_pro/src/controllers/chat_controller.dart';
import 'package:chit_chat_pro/src/model/message.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/mdi.dart';
import 'package:iconify_flutter_plus/icons/typcn.dart';
import 'package:iconify_flutter_plus/icons/uiw.dart';

class PromptSection extends StatelessWidget {
  final ChatController controller;
  final int index;
  PromptSection(this.controller, this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    Message userPrompt = controller.prompts[index];
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(radius: 15, backgroundColor: Colors.purpleAccent,), Gap(10),
            Text('You', style: Theme.of(context).primaryTextTheme.headlineSmall!.copyWith(fontWeight: FontWeight.w800, fontSize: 22)),
            Spacer(),
            InkWell(
              onTap: () => controller.copy(index),
              child: Iconify(Uiw.copy, color: Colors.grey, size: 20,)
            ),
            Gap(4),
            if(controller.contents.length-1 == index) ...[
              InkWell(
                onTap: () => controller.refreshChat(),
                child: Iconify(Typcn.refresh_outline, color: Colors.grey, size: 27,)
              ),
              Gap(4),
            ],
            InkWell(
              onTap: () => controller.deletePromptContentSection(index),
              child: Iconify(Mdi.delete_outline, color: Colors.grey,),
            ),
            Gap(4),
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
