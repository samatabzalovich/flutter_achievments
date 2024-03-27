import 'dart:io' show File;

import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/common/widgets/custom_navbar.dart';
import 'package:flutter_achievments/features/profile/presentation/widgets/common/image_crop_body.dart';


class ImageCropPage extends StatelessWidget {
  final File image;

  const ImageCropPage({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomNavBar('Настройка аватара', data: null),
        body: SafeArea(
          child: ImageCropBody(
            image: image,
          ),
        ));
  }
}
