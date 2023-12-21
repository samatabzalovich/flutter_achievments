import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/constant/colors.dart';
import 'package:flutter_achievments/core/widgets/custom_text.dart';
import 'package:flutter_achievments/features/splash/presentation/widgets/auth_buttons.dart';
import 'package:flutter_achievments/features/splash/presentation/widgets/social_media.dart';

class FormSection extends StatelessWidget {
  const FormSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          CustomText(
            'Обучай навыкам и привычкам',
            fontSize: 16,
            textAlign: TextAlign.center,
            color: greyColor,
          ),
          CustomText(
            'с 6+ лет',
            fontSize: 16,
            textAlign: TextAlign.center,
            color: greyColor,
          ),
          SizedBox(height: 50),
          AuthButtons(),
          SizedBox(height: 20),
          SocialMedia()
        ],
      ),
    );
  }
}
