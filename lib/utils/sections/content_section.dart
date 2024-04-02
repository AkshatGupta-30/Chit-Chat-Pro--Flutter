import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chit_chat_pro/src/controllers/chat_controller.dart';
import 'package:chit_chat_pro/src/model/message.dart';
import 'package:fluentui_emoji_icon/fluentui_emoji_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter/iconify.dart';

class ContentSection extends StatelessWidget {
  final int index;
  ContentSection(this.index, {super.key});

  final controller = Get.find<ChatController>();

  @override
  Widget build(BuildContext context) {
    Message? gptContent = (index < controller.contents.length) ? controller.contents[index] : null;
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
            if(gptContent != null)
              InkResponse(
                onTap: () => controller.showDetailDialog(context, index),
                child: Iconify(RadixIcons.open_in_new_window, color: Colors.grey,)
              ),
          ]
        ),
        (gptContent != null)
            ?  Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(width: 30,),
                Gap(10),
                Expanded(
                  child: (controller.isAnimated[index])
                      ? SelectableText(gptContent.content, style: Theme.of(context).primaryTextTheme.bodyLarge!.copyWith(fontSize: 15),)
                      : AnimatedTextKit(
                        animatedTexts: [
                          TypewriterAnimatedText(
                            gptContent.content, speed: Duration(milliseconds: 20),
                            textStyle: Theme.of(context).primaryTextTheme.bodyLarge!.copyWith(fontSize: 15),
                          ),
                        ],
                        repeatForever: false, totalRepeatCount: 1, isRepeatingAnimation: false,
                        displayFullTextOnTap: true,
                        onFinished: () => controller.isAnimated[index] = true,
                      ),
                )
              ]
            )
            : Padding(
              padding: EdgeInsets.all(10),
              child: SpinKitThreeBounce(color: Theme.of(context).primaryTextTheme.bodyLarge!.color, size: 25,),
            )
      ],
    );
  }
}
