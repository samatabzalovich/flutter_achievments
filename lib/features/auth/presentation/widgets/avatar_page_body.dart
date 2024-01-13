import 'dart:io' show File;

import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/common/widgets/blue_green_buttons.dart';
import 'package:flutter_achievments/core/common/widgets/custom_button.dart';
import 'package:flutter_achievments/core/common/widgets/custom_text.dart';
import 'package:flutter_achievments/core/common/widgets/custom_text_button.dart';
import 'package:flutter_achievments/core/common/entity/avatar.dart';
import 'package:flutter_achievments/features/auth/presentation/widgets/select_avatar_form.dart';

class AvatarPageBody extends StatelessWidget {
  const AvatarPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    AvatarEntity? _avatar;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SelectAvatarForm(
            userName: 'Иванов',
            onPicked: (avatar) {
            _avatar = avatar;
          }),
          TextAndGreenButtons(
            blueText: 'Пропустить',
            greenText: 'Выбрать',
            textPressed: () {
              Navigator.pop(context, _avatar);
            },
            greenPressed: () {
              Navigator.pop(context, _avatar);
            },
          )
        ],
      ),
    );
  }
}
