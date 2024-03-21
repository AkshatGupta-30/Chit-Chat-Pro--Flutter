import 'package:chit_chat_pro/src/controllers/chat_controller.dart';
import 'package:chit_chat_pro/src/model/message.dart';
import 'package:fluentui_emoji_icon/fluentui_emoji_icon.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/radix_icons.dart';

class ContentSection extends StatelessWidget {
  final int index;
  ContentSection(this.index, {super.key});

  final controller = Get.find<ChatController>();

  @override
  Widget build(BuildContext context) {
    Message gptContent = controller.contents[index];
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            FluentUiEmojiIcon(fl: Fluents.flRobot, w: 30, h: 30,),
            Gap(5),
            Container(
              height: 30, padding: EdgeInsets.symmetric(horizontal: 5), alignment: Alignment.center,
              child: Text(
                'Chit Chat Pro',
                style: Theme.of(context).primaryTextTheme.headlineSmall!.copyWith(
                  fontWeight: FontWeight.w800, fontSize: 21,
                )
              )
            ),
            Spacer(),
            InkWell(
              onTap: () => controller.showDetailDialog(context, index),
              child: Iconify(RadixIcons.open_in_new_window, color: Colors.grey,)
            ),
          ]
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(width: 30,),
            Gap(10),
            Expanded(
              child: SelectableText(
                gptContent.content,
                style: Theme.of(context).primaryTextTheme.bodyLarge!.copyWith(fontSize: 15),
              ),
            ),
          ]
        )
      ],
    );
  }
}
