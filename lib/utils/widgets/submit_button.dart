import 'package:chit_chat_pro/src/controllers/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter/iconify.dart';

class SubmitButtton extends StatelessWidget {
  SubmitButtton({super.key});

  final controller = Get.find<ChatController>();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx(() => InkWell(
        onTap: () => (
          controller.isMainChat.value &&
          controller.textController.text.isNotEmpty &&
          controller.isButtonEnabled.value) 
            ? controller.submit()
            : null,
        borderRadius: BorderRadius.circular(45),
        child: Container(
          height: 45, padding: const EdgeInsets.symmetric(), alignment: Alignment.center,
          decoration: BoxDecoration(
            color: (controller.isButtonEnabled.value) ? const Color(0xFF2d6a4f) : Colors.grey.shade900,
            borderRadius: BorderRadius.circular(45)
          ),
          child: (controller.isButtonEnabled.value)
              ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Submit', style: Theme.of(context).primaryTextTheme.headlineSmall!),
                  const Gap(2),
                  const Iconify(MaterialSymbols.send_rounded, size: 32, color: Colors.white,)
                ],
              )
              : const SpinKitDancingSquare(color: Colors.white, size: 40,),
        ),
      )),
    );
  }
}
