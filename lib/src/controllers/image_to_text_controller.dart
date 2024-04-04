import 'dart:io';

import 'package:chit_chat_pro/src/pages/image_text_dialog.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:iconify_flutter/iconify.dart';
import 'package:image_picker/image_picker.dart';

class ImageToTextController extends GetxController {
  final ImagePicker picker = ImagePicker();
  final imageFile = File('').obs;
  final textScanning = false.obs;
  final scannedText = ''.obs;

  final displayText = ''.obs;
  final textController = TextEditingController();
  final focusNode = FocusNode();

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
      if(pickedImage != null) {
        imageFile.value = File(pickedImage.path);
        _getRecognizedText();
      }
    } catch (e) {
      textScanning.value = false;
      imageFile.value = File('');
      e.printInfo();
    }
    Navigator.pop(context);
  }

  void removeImage() {
    imageFile.value = File('');
    scannedText.value = '';
    textController.clear();
    textScanning.value = false;
  }

  void _getRecognizedText() async {
    textScanning.value = true;
    final inputImage = InputImage.fromFilePath(imageFile.value.path);
    final textDetector = GoogleMlKit.vision.textRecognizer();
    RecognizedText recognizedText = await textDetector.processImage(inputImage);
    await textDetector.close();
    scannedText.value = '';
    for(TextBlock block in recognizedText.blocks) {
      for(TextLine line in block.lines) {
        scannedText.value = '$scannedText${line.text}\n';
      }
    }
    scannedText.value = scannedText.value.substring(0, scannedText.value.lastIndexOf('\n'));
    displayText.value = scannedText.value;
    textController.text = scannedText.value;
    textScanning.value = false;
  }

  showImageTextDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: ImageTextDialog()
        )
      ),
      barrierDismissible: !focusNode.hasFocus
    );
  }

  @override
  void onClose() {
    textController.dispose();
    super.onClose();
  }

  void doneChangeText() => displayText.value = textController.text;

  void resetText() {
    textController.text = scannedText.value;
    displayText.value = scannedText.value;
  }
}