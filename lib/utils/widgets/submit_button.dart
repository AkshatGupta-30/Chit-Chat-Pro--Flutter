import 'package:chit_chat_pro/src/controllers/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/material_symbols.dart';

class SubmitButtton extends StatelessWidget {
  final ChatController controller;
  const SubmitButtton({super.key, required this.controller,});

  @override
  Widget build(BuildContext context) {
    return Obx(() => ElevatedButton(
      onPressed: () => (
        controller.isMainChat.value &&
        controller.textController.text.isNotEmpty &&
        controller.isButtonEnabled.value) 
          ? controller.submit()
          : null,
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll((controller.isButtonEnabled.value) ? null : Colors.grey.shade900)
      ),
      child: (controller.isButtonEnabled.value)
          ? Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Submit', style: Theme.of(context).primaryTextTheme.headlineSmall!),
              Gap(2),
              Iconify(MaterialSymbols.send_rounded, size: 32, color: Colors.white,)
            ],
          )
          : SpinKitDancingSquare(color: Colors.white, size: 40,),
    ));
  }
}
