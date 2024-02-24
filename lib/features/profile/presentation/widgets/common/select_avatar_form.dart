import 'dart:io' show File;
import 'package:flutter_achievments/core/common/widgets/avatar_builder.dart';

import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/constant/colors.dart';
import 'package:flutter_achievments/core/routes/custom_page_builder.dart';
import 'package:flutter_achievments/core/common/widgets/custom_text.dart';
import 'package:flutter_achievments/core/common/avatar/avatar.dart';
import 'package:flutter_achievments/features/profile/presentation/pages/crop_image_page.dart';

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
  final ImagePicker picker = ImagePicker();
  File? _pickedImage;

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
        const SizedBox(
          height: 20,
        ),
        _imagePicker(),
        const SizedBox(
          height: 20,
        ),
        GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 9,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 15,
              mainAxisSpacing: 24,
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
                    borderRadius: const BorderRadius.all(Radius.circular(
                        98)), // Radius should be half of the width and height for a perfect circle
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(
                        Radius.circular(98)), // Same radius as the Container
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
          child: const ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(48)),
            child: ColoredBox(
              color: borderBlueColor,
              child: SizedBox(
                  width: 48,
                  height: 48,
                  child: Icon(
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
              _showImagePicker(context);
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
          child: const ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(48)),
            child: ColoredBox(
              color: borderBlueColor,
              child: SizedBox(
                  width: 48,
                  height: 48,
                  child: Icon(
                    Icons.drive_folder_upload_rounded,
                    color: Colors.white,
                  )),
            ),
          ),
        )
      ],
    );
  }

  void _showImagePicker(BuildContext context) {
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
                      _pickImage(ImageSource.gallery);
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const CustomText.darkBlueTitle(
                    'Камера',
                    fontSize: 16,
                  ),
                  onTap: () {
                    _pickImage(ImageSource.camera);
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

  Future _pickImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      await _cropImage(File(pickedFile.path));
    }
  }

  Future<void> _cropImage(File pickedFile) async {
    NetworkAvatarEntity? networkAvatar = await Navigator.push(
      context,
      MyCustomRouteFadeTransition<NetworkAvatarEntity>(
        route: ImageCropPage(
          image: pickedFile,
        ),
      ),
    );
    if (networkAvatar != null) {
      setState(() {
        _avatar = networkAvatar;
        widget.onPicked(_avatar!);
      });
    }
  }
}
//9597835