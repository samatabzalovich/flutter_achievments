import 'dart:io' show File;

import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/common/avatar/avatar.dart';
import 'package:flutter_achievments/core/common/widgets/avatar_builder.dart';
import 'package:flutter_achievments/core/common/widgets/custom_text.dart';
import 'package:flutter_achievments/core/constant/colors.dart';
import 'package:flutter_achievments/core/routes/custom_page_builder.dart';
import 'package:flutter_achievments/core/common/pages/crop_image_page.dart';
import 'package:flutter_achievments/core/services/get_it.dart';
import 'package:flutter_achievments/core/utils/image_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class SelectAvatarForm extends StatefulWidget {
  const SelectAvatarForm(
      {super.key, required this.onPicked, required this.userName});
  final Function(AvatarEntity) onPicked;
  final String userName;

  @override
  State<SelectAvatarForm> createState() => _SelectAvatarFormState();
}

class _SelectAvatarFormState extends State<SelectAvatarForm> {
  // File? _pickedImage;

  AvatarEntity? _avatar;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomText.darkBlueTitle(
          'или сделай фото',
          fontSize: 16,
        ),
        SizedBox(
          height: 20.h,
        ),
        _imagePicker(),
        SizedBox(
          height: 20.h,
        ),
        GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 9,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: MediaQuery.of(context).size.width * 0.1,
              mainAxisSpacing: 24.h,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _avatar = AssetAvatarEntity(
                      'assets/avatars/$index.png',
                    );
                  });
                  widget.onPicked(_avatar!);
                },
                child: Container(
                  width: 98,
                  height: 98,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(
                            0.4), // Shadow color with some transparency
                        blurRadius: 30, // Softening the shadow
                        spreadRadius: 0, // Extending the shadow
                        offset: const Offset(0, 4), // Positioning the shadow
                      ),
                    ],
                    borderRadius: const BorderRadius.all(Radius.circular(60)),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(
                        Radius.circular(60)), // Same radius as the Container
                    child: Image.asset(
                      'assets/avatars/$index.png',
                      fit: BoxFit.cover,
                    ), // Make sure to use BoxFit.cover
                  ),
                ),
              );
            })
      ],
    );
  }

  Widget _imagePicker() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            _pickImage(ImageSource.camera);
          },
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(48.r)),
            child: ColoredBox(
              color: borderBlueColor,
              child: SizedBox(
                  width: 48.w,
                  height: 48.w,
                  child: const Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                  )),
            ),
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        GestureDetector(
            onTap: () {
              sl<ImageUtils>(). showImagePicker(context, pickImageFunc: _pickImage);
            },
            child: AvatarBuilder(
              widget.userName,
              width: 98,
              avatarEntity: _avatar,
            )),
        const SizedBox(
          width: 16,
        ),
        GestureDetector(
          onTap: () {
            _pickImage(ImageSource.gallery);
          },
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(48)),
            child: ColoredBox(
              color: borderBlueColor,
              child: SizedBox(
                  width: 48.w,
                  height: 48.w,
                  child: const Icon(
                    Icons.drive_folder_upload_rounded,
                    color: Colors.white,
                  )),
            ),
          ),
        )
      ],
    );
  }

  

  Future _pickImage(ImageSource source) async {
    final pickedFile = await sl<ImageUtils>().pickImage(source);

    if (pickedFile != null) {
      await _cropImage(File(pickedFile.path));
    }
  }

  Future<void> _cropImage(File pickedFile) async {
    final networkAvatar = await sl<ImageUtils>().cropImage(pickedFile, context);
    if (networkAvatar != null) {
      setState(() {
        _avatar = networkAvatar;
        widget.onPicked(_avatar!);
      });
    }
  }
}
//9597835