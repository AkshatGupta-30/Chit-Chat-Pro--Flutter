import 'dart:io';

import 'package:chit_chat_pro/src/controllers/image_to_text_controller.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter/iconify.dart';
import 'package:shimmer/shimmer.dart';

class ImageView extends StatelessWidget {
  ImageView({super.key});

  final controller = Get.find<ImageToTextController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if(controller.imageFile.value.path.isEmpty) return SizedBox();
      return Container(
        padding: EdgeInsets.only(left: 2, top: 2, right: 2, bottom: 10),
        child: Row(
          children: [
            _displayImage(), Gap(5), Iconify(Bx.bxs_right_arrow_alt, color: Colors.white), Gap(5),
            Expanded(child: _textFromImage(context)),
            Gap(5), _edit(context)
          ],
        ),
      );
    });
  }

  _displayImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Stack(
        children: [
          Image.file(File(controller.imageFile.value.path), width: 50, height: 50, fit: BoxFit.cover,),
          if(controller.textScanning.value)
            Shimmer.fromColors(
              baseColor: Colors.transparent, highlightColor: Colors.white38,
              child: Container(width: 50, height: 50, color: Colors.black.withOpacity(1),),
            ),
          Container(
            width: 50, height: 50, alignment: Alignment.center, color: Colors.white12,
            child: GestureDetector(
              onTap: () => controller.removeImage(),
              child: CircleAvatar(
                radius: 10, backgroundColor: Colors.grey.shade900,
                child: Iconify(Ic.baseline_close, size: 15, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _textFromImage(BuildContext context) {
    final theme = Theme.of(context);
    final media = MediaQuery.sizeOf(context);
    if(controller.textScanning.value) {
      return Shimmer.fromColors(
        baseColor: Colors.grey.shade900, highlightColor: Colors.grey.shade700,
        child: Column(
          children: [
            Container(
              width: double.maxFinite, height: 15,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(20)
              )
            ),
            Gap(2),
            Container(
              width: double.maxFinite, height: 15,
              margin: EdgeInsets.only(right: media.width / 10),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(20)
              )
            )
          ],
        ),
      );
    }
    String displayText = controller.displayText.value;
    if ((displayText.split('\n').length - 1) >= 2) {
      int index = displayText.indexOf('\n', displayText.indexOf('\n') + 1);
      displayText = '${displayText.substring(0, index)}....${displayText.substring(index)}';
    }
    return Text(
      displayText, maxLines: 2, overflow: TextOverflow.ellipsis,
      style: theme.textTheme.bodyLarge!.copyWith(color: Colors.white54)
    );
  }

  _edit(BuildContext context) {
    if(controller.textScanning.value) {
      return Shimmer.fromColors(
        baseColor: Colors.grey.shade900, highlightColor: Colors.grey.shade700,
        child: Container(
          width: 35, height: 35,
          decoration: BoxDecoration(
            color: Colors.black,
            shape: BoxShape.circle
          ),
        ),
      );
    }
    return IconButton(
      onPressed: () => controller.showImageTextDialog(context),
      padding: EdgeInsets.zero,
      style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.deepPurple.shade900)),
      icon: Iconify(MaterialSymbols.edit_note_rounded, color: Colors.white,)
    );
  }
}