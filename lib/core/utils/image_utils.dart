import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/common/avatar/avatar.dart';
import 'package:flutter_achievments/core/common/pages/crop_image_page.dart';
import 'package:flutter_achievments/core/common/widgets/custom_text.dart';
import 'package:flutter_achievments/core/constant/colors.dart';
import 'package:flutter_achievments/core/routes/custom_page_builder.dart';
import 'package:image_picker/image_picker.dart';

class ImageUtils {
  final ImagePicker picker;
  const ImageUtils(this.picker);
  Future<File?> pickImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    return pickedFile == null ? null : File(pickedFile.path);
  }

  Future<NetworkAvatarEntity?> cropImage(
      File pickedFile, BuildContext context) async {
    NetworkAvatarEntity? networkAvatar = await Navigator.push(
      context,
      MyCustomRouteFadeTransition<NetworkAvatarEntity>(
        name: '/crop-image',
        route: ImageCropPage(
          image: pickedFile,
        ),
      ),
    );
    return networkAvatar;
  }

  void showImagePicker(BuildContext context,
      {required Function(ImageSource) pickImageFunc}) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 20,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: SizedBox(
                    height: 4,
                    width: 80,
                    child: ColoredBox(
                      color: borderBlueColor,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const CustomText.darkBlueTitle(
                  'Выберите источник',
                ),
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const CustomText.darkBlueTitle(
                      'Галлерея',
                      fontSize: 16,
                    ),
                    onTap: () {
                      pickImageFunc(ImageSource.gallery);
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const CustomText.darkBlueTitle(
                    'Камера',
                    fontSize: 16,
                  ),
                  onTap: () {
                    pickImageFunc(ImageSource.camera);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<File?> pickVideoFromGallery(BuildContext context) async {
    File? video;
    final pickedVideo =
        await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (pickedVideo != null) {
      video = File(pickedVideo.path);
    }

    return video;
  }
}
