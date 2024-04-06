import 'dart:io';

import 'package:chit_chat_pro/src/pages/image_text_dialog.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:iconify_flutter/iconify.dart';
import 'package:image_cropper/image_cropper.dart';
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
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () => _pickImage(context, ImageSource.camera),
              padding: const EdgeInsets.all(6),
              icon: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 30, backgroundColor: Colors.grey.shade800,
                    child: const Iconify(MaterialSymbols.camera, color: Colors.white, size: 35,)
                  ),
                  Text('Camera', style: theme.textTheme.bodyLarge!.copyWith(color: Colors.grey.shade200))
                ],
              )
            ),
            const Gap(5),
            IconButton(
              onPressed: () => _pickImage(context, ImageSource.gallery),
              padding: const EdgeInsets.all(6),
              icon: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 30, backgroundColor: Colors.grey.shade800,
                    child: const Iconify(Ooui.image_gallery, color: Colors.white, size: 35,)
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
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    RecognizedText recognizedText = await textRecognizer.processImage(inputImage);
    await textRecognizer.close();
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

  void doneChangeText() => displayText.value = textController.text;

  void resetText() {
    textController.text = scannedText.value;
    displayText.value = scannedText.value;
  }

  Future<void> crop(BuildContext context) async {
    Navigator.pop(context);
    File? croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.value.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      androidUiSettings: AndroidUiSettings(
        toolbarTitle: 'Edit Image', toolbarColor: Colors.teal.shade700, toolbarWidgetColor: Colors.white,
        initAspectRatio: CropAspectRatioPreset.original, lockAspectRatio: false,
        cropGridColor: Colors.grey, cropFrameColor: Colors.grey, cropFrameStrokeWidth: 5
      ),
    );
    if(croppedFile != null) {
      imageFile.value = croppedFile;
      _getRecognizedText();
    }
  }

  @override
  void onClose() {
    textController.dispose();
    super.onClose();
  }
}