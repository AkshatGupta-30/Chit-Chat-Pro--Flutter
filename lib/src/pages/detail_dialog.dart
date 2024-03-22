import 'package:chit_chat_pro/src/controllers/text_to_speech_controller.dart';
import 'package:chit_chat_pro/src/model/message.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:fluentui_emoji_icon/fluentui_emoji_icon.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/material_symbols.dart';
import 'package:iconify_flutter_plus/icons/uiw.dart';
import 'package:sliver_tools/sliver_tools.dart';

class DetailDialog extends StatelessWidget {
  final int index;
  DetailDialog(this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      global: false,
      init: TTSController(index),
      builder: (controller) {
        Message userPrompt = controller.chatController.prompts[index];
        Message gptMessage = controller.chatController.contents[index];
        return Scaffold(
          backgroundColor: Color(0xFF1A1A1A),
          body: Container(
            padding: EdgeInsets.all(15),
            child: CustomScrollView(
              shrinkWrap: true,
              slivers: [
                SliverAppBar(
                  pinned: true,
                  backgroundColor: Color(0xFF1A1A1A), shadowColor: Colors.transparent, surfaceTintColor: Colors.transparent,
                  leadingWidth: 35,
                  leading: FluentUiEmojiIcon(fl: Fluents.flBoy, w: 20, h: 20,),
                  titleSpacing: 10, centerTitle: false,
                  title: Text(
                    'You', style: Theme.of(context).primaryTextTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.w800, fontSize: 21,
                    ),
                  ),
                  actions: [
                    InkWell(
                      onTap: () {}, //TODO - Copy Prompt
                      child: Iconify(Uiw.copy, color: Colors.grey, size: 20,)
                    ),
                    Gap(8),
                  ],
                ),
                SliverPinnedHeader(
                  child: Container(
                    color: Color(0xFF1A1A1A),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ExpandableText(
                          userPrompt.content, expandText: 'Show more..', collapseText: 'Show Less...',
                          animation: true, maxLines: 5,
                          style: Theme.of(context).primaryTextTheme.bodyLarge!.copyWith(fontSize: 15),
                          linkColor: Colors.blue, linkEllipsis: true,
                        ),
                        Divider(color: Colors.white54,),
                      ],
                    ),
                  ),
                ),
                SliverAppBar(
                  pinned: true, elevation: 3,
                  backgroundColor: Color(0xFF1A1A1A), shadowColor: Colors.transparent, surfaceTintColor: Colors.transparent,
                  leadingWidth: 35,
                  leading: FluentUiEmojiIcon(fl: Fluents.flRobot, w: 20, h: 20,),
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
                      child: Iconify(Uiw.copy, color: Colors.grey, size: 20,)
                    ),
                    Gap(8),
                  ],
                ),
                SliverToBoxAdapter(
                  child: SelectableText(gptMessage.content, style: Theme.of(context).primaryTextTheme.bodyLarge!.copyWith(fontSize: 15),),
                ),
              ],
            ),
          ),
          bottomNavigationBar: Container(
            width: double.maxFinite, height: kBottomNavigationBarHeight, color: Colors.grey.shade800,
            child: Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {},
                  child: Iconify(MaterialSymbols.skip_previous_rounded, color: Colors.blue, size: 40,)
                ),
                InkWell(
                  onTap: () => controller.playPauseTapped(),
                  child: Iconify( // TODO - Play/Pause(MaterialSymbols.pause_rounded/MaterialSymbols.play_arrow_rounded)
                    (controller.isPlaying.value) ? MaterialSymbols.pause_rounded : MaterialSymbols.play_arrow_rounded,
                    color: Colors.lightGreenAccent, size: 45,
                  ),
                ),
                InkWell(
                  onTap: () => controller.stop(),
                  child: Iconify(MaterialSymbols.stop_circle_rounded, size: 45,
                  color: (controller.isStopped.value) ? Colors.white : Colors.redAccent,
                ),
                ),
                InkWell(
                  onTap: () {},
                  child: Iconify(MaterialSymbols.skip_next_rounded, color: Colors.blue, size: 40,)
                )
              ],
            ),
          ),
        ));
      }
    );
  }
}