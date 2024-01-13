// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ffi';
import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/constant/colors.dart';
import 'package:flutter_achievments/core/enums/user_type.dart';
import 'package:flutter_achievments/core/common/widgets/animated_custom_button.dart';
import 'package:flutter_achievments/core/common/widgets/custom_text.dart';
import 'package:flutter_achievments/core/common/widgets/custom_text_button.dart';
import 'package:flutter_achievments/core/common/widgets/custom_text_field.dart';
import 'package:flutter_achievments/features/auth/presentation/pages/sign_up/avatar_page.dart';
import 'package:flutter_achievments/features/auth/presentation/widgets/choose_type_butons.dart';
import 'package:flutter_achievments/features/auth/presentation/widgets/custom_switch_description.dart';
class AcoountPrefForm extends StatefulWidget {
  const AcoountPrefForm(
    this.userInfo, {
    Key? key,
  }) : super(key: key);
  final Map<String, dynamic> userInfo;

  @override
  State<AcoountPrefForm> createState() => _AcoountPrefFormState();
}

class _AcoountPrefFormState extends State<AcoountPrefForm>
    with SingleTickerProviderStateMixin {
  late FocusNode _focusNode; // for unfocus
  bool isTypeShown = false; // show as a mom or dad
  late AnimationController _controller;
  late Map<String, dynamic> userInfo = {};
  bool disabled = true;
  @override
  void initState() {
    super.initState();
    userInfo.addAll(widget.userInfo);
    _focusNode = FocusNode();
    _controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300)); // for button animation
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  bool isNameNotEmpty = false; // for name validation
  bool isTypeSelected = false; // whether type is selected
  void _isButtonEnabled() {
    if (isNameNotEmpty && isTypeSelected) {
      _controller.forward();
      disabled = false;
    } else {
      disabled = true;
      _controller.reverse();
    }
  }

  

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
            height: MediaQuery.of(context).size.height / 2.5,
            child: _formBuilder()),
        AnimatedCustomButton('Продолжить',
            controller: _controller,
            onPressed: disabled
                ? null
                : () {
                    Navigator.of(context).pushNamed(
                      AvatarPage.routeName,
                      arguments: userInfo,
                    );
                  },
            width: MediaQuery.of(context).size.width / 1.67),
      ],
    );
  }

  Widget _formBuilder() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const CustomText.darkBlueTitle('Введите свои данные'),
        const CustomText.darkBlueTitle(
          'чтобы члены\nсемьи узнавали тебя',
          fontSize: 16,
        ),
        CustomTextField(
            labelText: 'Твое имя (взрослого):',
            focusNode: _focusNode,
            onChanged: (name) {
              userInfo['name'] = name;
              _isButtonEnabled();
            },
            validator: (name) {
              if (name.isEmpty) {
                isNameNotEmpty = false;
                return isNameNotEmpty;
              }
              isNameNotEmpty = true;
              return isNameNotEmpty;
            },
            onSubmitted: (name) {
              _focusNode.unfocus();
            },
            isPassword: false),
        const CustomText.darkBlueTitle('Вы мама или папа?'),
        ChooseTypeButtons(
          firstType: Role.mom,
          secondType: Role.dad,
          selectedType: userInfo['role'] as Role,
          firstTypeSelected: (type) {
          userInfo['userType'] = type;
          _isButtonEnabled();
        }, secondTypeSelected: (type) {
          userInfo['userType'] = type;
          _isButtonEnabled();
        }),
        CustomSwitchDescription(
          paragraphFirst:
              'Если включен, то для детей в приложении ты отображаешься как “Папа” или “Мама”.',
          paragraphSecond:
              'Если выключен, то для детей в приложении ты отображаешься под заданным тобой именем.',
          description: 'Отображать как\nПапа/Мама',
          onChanged: (value) {
            setState(() {
              isTypeShown = value;
              userInfo['isTypeShown'] = isTypeShown;
            });
          },
        ),
      ],
    );
  }
}
