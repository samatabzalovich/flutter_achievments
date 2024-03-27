import 'dart:io';

import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/common/avatar/avatar.dart';
import 'package:flutter_achievments/core/common/widgets/custom_hexagon.dart';
import 'package:flutter_achievments/core/common/widgets/custom_text.dart';
import 'package:flutter_achievments/core/common/widgets/custom_text_no_tr.dart';
import 'package:flutter_achievments/core/constant/colors.dart';
import 'package:flutter_achievments/core/services/get_it.dart';
import 'package:flutter_achievments/core/utils/image_utils.dart';
import 'package:flutter_achievments/features/task/domain/entities/shared/category_entity.dart';
import 'package:flutter_achievments/generated/locale_keys.g.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class ChooseCategoryBody extends StatefulWidget {
  const ChooseCategoryBody(
      {super.key, required this.onCategoryAndTaskAvatarSelected, });
  final Function(CategoryEntity? category, AvatarEntity avatar)
      onCategoryAndTaskAvatarSelected;

  @override
  State<ChooseCategoryBody> createState() => _ChooseCategoryBodyState();
}

class _ChooseCategoryBodyState extends State<ChooseCategoryBody> {
  Color color = Colors.blue;
  CategoryEntity? selectedCategory;
  AvatarEntity selectedAvatar = const NoneAvatarEntity();
  late bool showWarningMessage;

  @override
  void initState() {
    showWarningMessage = false;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 140.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [_buildChooseCategory(), _buildChooseImage()],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Visibility(
          visible: showWarningMessage,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 24.h,
                height: 24.h,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: redColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Center(
                    child: CustomTextNoTr(
                      '!',
                      color: Colors.white,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              const Flexible(
                child: CustomText(
                  LocaleKeys.requiredCategory,
                  color: redColor,
                  fontSize: 14,
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.visible,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _showCategoryDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const CustomText(
            LocaleKeys.choose,
            color: lightBlue,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          content: SizedBox(
            height: 300.h,
            width: 200.w,
            child: ListView.builder(
              itemCount: CategoryEntity.defaultCategories().length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    setState(() {
                      if (selectedCategory ==
                          CategoryEntity.defaultCategories()[index]) {
                        selectedCategory = null;
                      } else {
                        selectedCategory =
                            CategoryEntity.defaultCategories()[index];
                      }

                      if (selectedCategory == null) {
                        showWarningMessage = true;
                      } else {
                        showWarningMessage = false;
                      }
                    });
                    widget.onCategoryAndTaskAvatarSelected(
                        selectedCategory, selectedAvatar);
                    Navigator.pop(context);
                  },
                  title: CustomText(
                    CategoryEntity.defaultCategories()[index].categoryName,
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  leading: CircleAvatar(
                    backgroundColor: Colors.primaries[index],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildChooseCategory() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomText.darkBlueTitle(
          LocaleKeys.category,
        ),
        SizedBox(
          width: 190.w,
          child: TextButton(
              style: ButtonStyle(
                alignment: Alignment.centerLeft,
                padding: MaterialStateProperty.all(EdgeInsets.only(left: 16.w)),
                backgroundColor: MaterialStateProperty.all(lightBlue2),
              ),
              onPressed: () {
                _showCategoryDialog();
              },
              child: const CustomText(
                LocaleKeys.choose,
                color: Colors.white,
                fontSize: 14,
                textAlign: TextAlign.left,
                fontWeight: FontWeight.w600,
              )),
        ),
        SizedBox(
          width: 190.w,
          child: TextButton(
              style: ButtonStyle(
                alignment: Alignment.centerLeft,
                padding: MaterialStateProperty.all(EdgeInsets.only(left: 16.w)),
                backgroundColor: MaterialStateProperty.all(Colors.white),
              ),
              onPressed: null,
              child: CustomText(
                selectedCategory != null
                    ? selectedCategory!.categoryName
                    : LocaleKeys.noCategory,
                color: Colors.lightBlue,
                fontSize: 14,
                textAlign: TextAlign.left,
                fontWeight: FontWeight.w600,
                overflow: TextOverflow.ellipsis,
              )),
        ),
      ],
    );
  }

  Widget _buildChooseImage() {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            sl<ImageUtils>().showImagePicker(context, pickImageFunc: pickImage);
          },
          child: CustomHexagon(
            size: 140.h,
            backgroundColor: color,
            child: RepaintBoundary(
              child: CustomHexagon(
                size: 120.h,
                backgroundColor: color,
                child: selectedAvatar is NoneAvatarEntity
                    ? Center(
                        child: SizedBox(
                        width: 20.h,
                        height: 20.h,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.black38,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Center(
                            child: CustomTextNoTr(
                              '?',
                              color: color,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ))
                    : (selectedAvatar as NetworkAvatarEntity).image!,
              ),
            ),
          ),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: SizedBox(
            width: 48.h,
            height: 48.h,
            child: FloatingActionButton(
              shape: const CircleBorder(),
              backgroundColor: Colors.white,
              elevation: 5,
              onPressed: () async {
                color = await showColorPickerDialog(
                  context,
                  color,
                  pickersEnabled: const <ColorPickerType, bool>{
                    ColorPickerType.both: false,
                    ColorPickerType.primary: false,
                    ColorPickerType.accent: false,
                    ColorPickerType.bw: false,
                    ColorPickerType.custom: false,
                    ColorPickerType.customSecondary: false,
                    ColorPickerType.wheel: true,
                  },
                );
                setState(() {});
              },
              child: SvgPicture.asset(
                'assets/icons/choose_color.svg',
              ),
            ),
          ),
        )
      ],
    );
  }

  Future pickImage(ImageSource source) async {
    final pickedFile = await sl<ImageUtils>().pickImage(source);

    if (pickedFile != null) {
      await _cropImage(File(pickedFile.path));
    }
  }

  Future<void> _cropImage(File pickedFile) async {
    final networkAvatar = await sl<ImageUtils>().cropImage(pickedFile, context);
    if (networkAvatar != null) {
      setState(() {
        selectedAvatar = networkAvatar;
        widget.onCategoryAndTaskAvatarSelected(
            selectedCategory, selectedAvatar);
      });
    }
  }
}
