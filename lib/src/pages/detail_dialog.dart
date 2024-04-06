import 'package:chit_chat_pro/src/controllers/chat_controller.dart';
import 'package:chit_chat_pro/src/controllers/text_to_speech_controller.dart';
import 'package:chit_chat_pro/src/model/message.dart';
import 'package:chit_chat_pro/src/pages/image_open.dart';
import 'package:fluentui_emoji_icon/fluentui_emoji_icon.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter/iconify.dart';

class DetailDialog extends StatelessWidget {
  final int index;
  DetailDialog(this.index, {super.key});

  final chatController = Get.find<ChatController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      global: false,
      init: TTSController(index),
      builder: (controller) {
        Message userPrompt = chatController.prompts[index];
        Message gptMessage = chatController.contents[index];
        return Container(
          color: const Color(0xFF1A1A1A),
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _promptHeading(context),
              _promptText(context, userPrompt),
              _gptHeading(context),
              _gptText(context, gptMessage),
              const Gap(15),
              _bottomControlButtons(controller)
            ],
          ),
        );
      }
    );
  }

  AppBar _promptHeading(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF1A1A1A), shadowColor: Colors.transparent, surfaceTintColor: Colors.transparent,
      leadingWidth: 35,
      leading: const FluentUiEmojiIcon(fl: Fluents.flBoy, w: 20, h: 20,),
      titleSpacing: 10, centerTitle: false,
      title: Text(
        'You', style: Theme.of(context).primaryTextTheme.headlineSmall!.copyWith(
          fontWeight: FontWeight.w800, fontSize: 21,
        ),
      ),
      actions: [
        InkWell(
          onTap: () {}, //TODO - Copy Prompt
          child: const Iconify(Uiw.copy, color: Colors.grey, size: 20,)
        ),
        const Gap(8),
      ],
    );
  }

  Container _promptText(BuildContext context, Message userPrompt) {
    String prompt = userPrompt.content;
    List<String> lines = prompt.split('\n');
    int newlineCount = lines.length - 1;
    if (newlineCount >= 4) {
      lines[4] += '....';
      prompt = lines.join('\n');
    }

    final List<String> parts = prompt.split('!!!!**!!!!');
    return Container(
      color: const Color(0xFF1A1A1A),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (parts.length == 1) ...[
            Text(prompt, style: Theme.of(context).primaryTextTheme.bodyLarge!.copyWith(fontSize: 15))
          ] else ...[
            InkWell(
              onTap: () => Get.to(() => ImageOpen(chatController.prompts[index].image!)),
              child: Text(
                "@image ",
                style: Theme.of(context).primaryTextTheme.bodyLarge!.copyWith(
                  fontSize: 15, color: Colors.blue,
                  decoration: TextDecoration.underline, decorationColor: Colors.blue
                )
              )
            ),
            Text(parts[1], style: Theme.of(context).primaryTextTheme.bodyLarge!.copyWith(fontSize: 15))
          ],
          const Divider(color: Colors.white54,),
        ],
      ),
    );
  }

  AppBar _gptHeading(BuildContext context) {
    return AppBar(
      elevation: 3,
      backgroundColor: const Color(0xFF1A1A1A), shadowColor: Colors.transparent, surfaceTintColor: Colors.transparent,
      leadingWidth: 35,
      leading: const FluentUiEmojiIcon(fl: Fluents.flRobot, w: 20, h: 20,),
      titleSpacing: 10, centerTitle: false,
      title: Text(
        'Chit Chat Pro',
        style: Theme.of(context).primaryTextTheme.headlineSmall!.copyWith(
          fontWeight: FontWeight.w800, fontSize: 21,
        ),
      ),
      actions: [
        InkWell(
          onTap: () {}, // TODO - Copy content
          child: const Iconify(Uiw.copy, color: Colors.grey, size: 20,)
        ),
        const Gap(8),
      ],
    );
  }

  _gptText(BuildContext context, Message gptMessage) {
    return Expanded(
      child: SingleChildScrollView(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.vertical,
        child: Text(
          gptMessage.content, overflow: TextOverflow.visible,
          style: Theme.of(context).primaryTextTheme.bodyLarge!.copyWith(fontSize: 15),
        ),
      ),
    );
  }

  Container _bottomControlButtons(TTSController controller) {
    return Container(
        width: double.maxFinite, height: kBottomNavigationBarHeight,
        decoration: BoxDecoration(
          color: Colors.grey.shade800,
          borderRadius: BorderRadius.circular(12)
        ),
        child: Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: () => controller.playPauseTapped(),
              child: Iconify(
                (controller.isPlaying.value) ? MaterialSymbols.pause_rounded : MaterialSymbols.play_arrow_rounded,
                color: Colors.lightGreenAccent, size: 45,
              ),
            ),
            InkWell(
              onTap: () => controller.stop(),
              child: Iconify(MaterialSymbols.stop_circle_rounded, size: 45,
                color: (controller.canStopped.value) ? Colors.redAccent : Colors.white,
              ),
            ),
            DropdownButton<double>(
              value: controller.rate.value,
              onChanged: (double? newValue) => controller.changeRate(newValue!),
              items: controller.dropdownItems,
              dropdownColor: Colors.grey.shade900, iconEnabledColor: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(15),
              underline: const SizedBox(),
              padding: EdgeInsets.zero,
            )
          ],
        ),
      ),
    );
  }
}