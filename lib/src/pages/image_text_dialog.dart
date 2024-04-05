import 'package:chit_chat_pro/src/controllers/image_to_text_controller.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter/iconify.dart';

class ImageTextDialog extends StatelessWidget {
  ImageTextDialog({super.key});

  final controller = Get.find<ImageToTextController>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      child: Container(
        color: theme.scaffoldBackgroundColor,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppBar(title: Text('Text from Image'),),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [_image(context), Gap(20), _textField(theme), Gap(10), _bottomButtons(theme)],
              ),
            )
          ],
        ),
      ),
    );
  }

  _image(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: 0, maxWidth: 125,
        minHeight: 0, maxHeight: 300
      ),
      child: Stack(
        children: [
          Image.file(controller.imageFile.value, fit: BoxFit.fitWidth),
          Positioned(
            top: 5, right: 5,
            child: InkWell(
              onTap: () => controller.crop(context),
              child: CircleAvatar(
                radius: 15, backgroundColor: Colors.black54,
                child: Iconify(MaterialSymbols.open_in_new, size: 15, color: Colors.white)
              )
            ),
          )
        ],
      )
    );
  }

  TextField _textField(ThemeData theme) {
    return TextField(
      controller: controller.textController, focusNode: controller.focusNode,
      minLines: 1, maxLines: 7,
      keyboardType: TextInputType.text, textInputAction: TextInputAction.done,
      style: theme.textTheme.bodyMedium!.copyWith(color: Colors.grey.shade300),
      onTapOutside: (_) => controller.focusNode.unfocus(),
      onChanged: (text) => controller.displayText.value = controller.textController.text,
      decoration: InputDecoration(
        suffix: Obx(() => (controller.scannedText.value == controller.displayText.value)
            ? SizedBox()
            : InkWell(
              onTap: controller.resetText,
              child: Container(
                width: 30, height: 30, padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(8)
                ),
                child: Iconify(Codicon.debug_restart, color: Colors.black, size: 15),
              ),
            ),
        )
      ),
    );
  }

  _bottomButtons(ThemeData theme) {
    return Obx(() {
      if(controller.scannedText.value == controller.displayText.value) return SizedBox();
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          
          Gap(20),
          InkWell(
            onTap: controller.doneChangeText,
            child: Container(
              width: 80, height: 40, alignment: Alignment.center,
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Color(0xFF52b788),
                borderRadius: BorderRadius.circular(30)
              ),
              child: Text('Done', style: theme.primaryTextTheme.titleLarge),
            ),
          ),
        ],
      );
    });
  }
}