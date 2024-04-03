import 'dart:io';

import 'package:chit_chat_pro/src/controllers/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter/iconify.dart';
import 'package:image_picker/image_picker.dart';

class ImageToTextController extends GetxController {
  final ImagePicker picker = ImagePicker();
  final imageFile = File('').obs;
  // ignore: unused_field
  final _chatController = Get.find<ChatController>();
  final textScanning = false.obs;
  final scannedText = ''.obs;

  void getImage(BuildContext context) {
    final theme = Theme.of(context);
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        height: 125, width: double.maxFinite, color: kDefaultIconDarkColor,
        padding: EdgeInsets.all(12),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () => _pickImage(context, ImageSource.camera),
              padding: EdgeInsets.all(6),
              icon: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 30, backgroundColor: Colors.grey.shade800,
                    child: Iconify(MaterialSymbols.camera, color: Colors.white, size: 35,)
                  ),
                  Text('Camera', style: theme.textTheme.bodyLarge!.copyWith(color: Colors.grey.shade200))
                ],
              )
            ),
            Gap(5),
            IconButton(
              onPressed: () => _pickImage(context, ImageSource.gallery),
              padding: EdgeInsets.all(6),
              icon: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 30, backgroundColor: Colors.grey.shade800,
                    child: Iconify(Ooui.image_gallery, color: Colors.white, size: 35,)
                  ),
                  Text('Gallery', style: theme.textTheme.bodyLarge!.copyWith(color: Colors.grey.shade200))
                ],
              )
            )
          ],
        ),
      ),
    );
  }

  void _pickImage(BuildContext context, ImageSource source) async {
    try {
      final pickedImage = await picker.pickImage(source: source);
      if(pickedImage != null) imageFile.value = File(pickedImage.path);
    } catch (e) {
      textScanning.value = false;
      imageFile.value = File('');
      e.printInfo();
    }
    Navigator.pop(context);
  }

  void removeImage() => imageFile.value = File('');
}