// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';
import 'dart:ui' as ui;

import 'package:crop_image/crop_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_achievments/core/common/avatar/avatar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import 'package:flutter_achievments/core/constant/colors.dart';
import 'package:flutter_achievments/core/common/widgets/blue_green_buttons.dart';
import 'package:flutter_achievments/core/common/widgets/custom_text.dart';
import 'package:flutter_achievments/core/common/widgets/loading/loading_screen.dart';

class ImageCropBody extends StatefulWidget {
  const ImageCropBody({
    super.key,
    required this.image,
  });
  final File image;

  @override
  State<ImageCropBody> createState() => _ImageCropBodyState();
}

class _ImageCropBodyState extends State<ImageCropBody> {
  late CropController _controller;
  @override
  void initState() {
    super.initState();
    _controller = CropController(
      aspectRatio: 1,
      defaultCrop: const Rect.fromLTRB(0, 0, 1, 1),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  ConstrainedBox(
                    constraints:  BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.5,
                    ),
                    child: CropImage(
                      /// Only needed if you expect to make use of its functionality like setting initial values of
                      /// [aspectRatio] and [defaultCrop].
                      controller: _controller,
                      /// The image to be cropped. Use [Image.file] or [Image.network] or any other [Image].
                      image: Image.file(widget.image),
                      /// The crop grid color of the outer lines. Defaults to 70% white.
                      gridColor: Colors.transparent,
                    
                      /// The crop grid color of the inner lines. Defaults to [gridColor].
                      gridInnerColor: Colors.transparent,
                    
                      /// The crop grid color of the corner lines. Defaults to [gridColor].
                      gridCornerColor: borderBlueColor,
                    
                      /// The size of the corner of the crop grid. Defaults to 25.
                      gridCornerSize: 50,
                    
                      /// The width of the crop grid thin lines. Defaults to 2.
                      gridThinWidth: 1,
                    
                      /// The width of the crop grid thick lines. Defaults to 5.
                      gridThickWidth: 6,
                    
                      /// The crop grid scrim (outside area overlay) color. Defaults to 54% black.
                      scrimColor: scaffoldBackground.withOpacity(0.7),
                    
                      /// True: Always show third lines of the crop grid.
                      /// False: third lines are only displayed while the user manipulates the grid (default).
                      alwaysShowThirdLines: false,
                    
                      /// The minimum pixel size the crop rectangle can be shrunk to. Defaults to 100.
                      minimumImageSize: 50,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const CustomText.darkBlueTitle(
                    'Сведи два пальца, чтобы уменьшить/увеличить.',
                    fontSize: 14,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const CustomText.darkBlueTitle(
                    'Перетащи одним мальцем чтобы переместить.',
                    fontSize: 14,
                  ),
                ],
              ),
            ),
            TextAndGreenButtons(
                textPressed: () {
                  Navigator.of(context).pop();
                },
                greenPressed: () async {
                  final Image image = await _controller.croppedImage();
                  final Rect rect =  _controller.crop;
                  if (mounted) {
                    final NetworkAvatarEntity avatar = NetworkAvatarEntity(widget.image.path, crop: rect, image: image);
                    Navigator.of(context).pop(avatar);
                  }
                                  
                },
                blueText: 'Назад',
                greenText: 'Принять')
          ],
        ));
  }
}
