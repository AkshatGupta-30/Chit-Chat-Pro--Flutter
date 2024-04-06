import 'package:chit_chat_pro/src/controllers/prompt_content_controller.dart';
import 'package:chit_chat_pro/src/model/message.dart';
import 'package:fluentui_emoji_icon/fluentui_emoji_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter/iconify.dart';

class PromptSection extends StatelessWidget {
  final int index;
  final PCController controller;
  const PromptSection(this.index, this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    Message userPrompt = controller.chatController.prompts[index];
    return Column(
      children: [
        _header(context, userPrompt),
        const Gap(5),
        _promptArea(userPrompt, context),
        const Gap(10),
        _submitCancelBtn(context)
      ],
    );
  }

  _header(BuildContext context, Message prompt) {
    return Obx(() => Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const FluentUiEmojiIcon(fl: Fluents.flBoy, w: 20, h: 20,), const Gap(10),
        Text('You', style: Theme.of(context).primaryTextTheme.headlineSmall!.copyWith(fontWeight: FontWeight.w800, fontSize: 22)),
        const Spacer(),
        if(prompt.image == null)
          Obx(() => (controller.isReEdit.value)
              ? const SizedBox()
              : InkWell(
                onTap: controller.editTapped,
                child: const Iconify(Bx.rename, color: Colors.grey,),
              )
          ),
        const Gap(8),
        InkWell(
          onTap: () => controller.chatController.copy(index),
          child: const Iconify(Uiw.copy, color: Colors.grey, size: 20,)
        ),
        const Gap(8),
        if(controller.chatController.contents.length-1 == index) ...[
          (controller.chatController.isButtonEnabled.value)
              ? InkWell(
                onTap: () => (controller.chatController.isButtonEnabled.value) ? controller.chatController.refreshChat() : null,
                child: const Iconify(Typcn.refresh_outline, color: Colors.grey, size: 27,)
              )
              : const SpinKitRipple(color: Colors.grey, size: 27,),
          const Gap(8),
        ],
        InkWell(
          onTap: () => controller.chatController.deletePromptContentSection(index),
          child: const Iconify(Mdi.delete_outline, color: Colors.grey,),
        ),
        const Gap(8),
      ]
    ));
  }

  Row _promptArea(Message userPrompt, BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        const Gap(30),
        Expanded(
          child: Obx(() {
            if(!controller.isReEdit.value) {
              String prompt = userPrompt.content;
              final List<String> parts = prompt.split('!!!!**!!!!');
              return RichText(
                text: TextSpan(
                  style: Theme.of(context).primaryTextTheme.bodyLarge!.copyWith(fontSize: 15),
                  children: (parts.length == 1)
                      ? [TextSpan(text: prompt, style: Theme.of(context).primaryTextTheme.bodyLarge!.copyWith(fontSize: 15))]
                      : [
                        TextSpan(
                          text: "@image ", style: Theme.of(context).primaryTextTheme.bodyLarge!.copyWith(
                            fontSize: 15, color: Colors.blue
                          )
                        ),
                        TextSpan(text: parts[1], style: Theme.of(context).primaryTextTheme.bodyLarge!.copyWith(fontSize: 15))
                      ]
                ),
              );
            }
            return TextField(
              controller: controller.promtTextController, focusNode: controller.focusNode,
              minLines: 1, maxLines: null, enabled: true,
              cursorColor: Colors.grey.shade400,
              style: Theme.of(context).primaryTextTheme.bodyLarge!.copyWith(fontSize: 15),
              decoration: InputDecoration(
                constraints: const BoxConstraints(minHeight: 10, minWidth: double.maxFinite),
                contentPadding: EdgeInsets.zero,
                border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade400),),
                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade400)),
                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade400)),
              ),
              onTapOutside: (_) => controller.focusNode.unfocus(),
            );
          }
        )
        )
      ]
    );
  }

  Obx _submitCancelBtn(BuildContext context) {
    return Obx(() => (controller.isReEdit.value)
        ? Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () => (controller.chatController.isButtonEnabled.value) ? controller.confirm() : null,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8), alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: (controller.chatController.isButtonEnabled.value) ? Colors.cyanAccent.shade700 : Colors.black,
                  borderRadius: BorderRadius.circular(12)
                ),
                child: Text('Confirm', style: Theme.of(context).primaryTextTheme.titleMedium,),
              ),
            ),
            const Gap(15),
            InkWell(
              onTap: controller.cancel,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8), alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.grey.shade700,
                  borderRadius: BorderRadius.circular(12)
                ),
                child: Text('Cancel', style: Theme.of(context).primaryTextTheme.titleMedium,),
              ),
            ),
          ],
        )
        : const Gap(0)
    );
  }
}
