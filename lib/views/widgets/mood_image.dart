import 'dart:io';

import 'package:flutter/material.dart';

class MoodImage extends StatelessWidget {
  final String? imagePath;
  double height;

  MoodImage({
    required this.imagePath,
    required this.height,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        clipBehavior: Clip.antiAlias,
        child: (imagePath != null)
            ? Image.file(File(imagePath ?? ''))
            : Container(),
      ),
    );
  }
}
