import 'dart:io';

import 'package:flutter/material.dart';

class ImageOpen extends StatelessWidget {
  final File image;
  ImageOpen(this.image, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Image Detail'),),
      body: SizedBox(
        width: double.maxFinite, height: double.maxFinite,
        child: InteractiveViewer(
          minScale: 1,
          maxScale: 3,
          child: Image.file(image, fit: BoxFit.contain)
        ),
      ),
    );
  }
}