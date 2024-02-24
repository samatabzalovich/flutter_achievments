
import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/common/widgets/custom_text.dart';
import 'package:flutter_achievments/core/common/widgets/custom_text_button.dart';
import 'package:flutter_achievments/core/constant/colors.dart';
import 'package:flutter_achievments/core/enums/user_type.dart';
import 'package:flutter_achievments/generated/locale_keys.g.dart';

class ChooseTypeButtons extends StatelessWidget {
  const ChooseTypeButtons({
    this.selectedType,
    super.key, required this.firstTypeSelected, required this.secondTypeSelected, required this.firstType,
    required this.secondType,
  });
  final Role ? selectedType;
  final Function(Role type) firstTypeSelected;
  final Function(Role type) secondTypeSelected;
  final Role firstType;
  final Role secondType;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _userTypeBuilder(firstType, firstTypeSelected, context),
        const CustomText(
          LocaleKeys.or,
          color: borderBlueColor,
        ),
        _userTypeBuilder(secondType, secondTypeSelected, context),
      ],
    );
  }

  Widget _userTypeBuilder(Role userType, Function(Role) onTap, BuildContext context) {
    return CustomTextButton(
      userType.name,
      backgroundColor: selectedType == userType
          ? borderBlueColor
          : Colors.white,
      onPressed: () {
        onTap(userType);
      },
      width: MediaQuery.of(context).size.width / 2.8,
      height: 48,
      textColor: selectedType == userType
          ? Colors.white
          : borderBlueColor,
    );
  }
}
