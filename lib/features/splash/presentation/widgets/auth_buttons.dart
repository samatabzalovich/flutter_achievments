import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/constant/colors.dart';
import 'package:flutter_achievments/core/common/widgets/custom_button.dart';
import 'package:flutter_achievments/core/common/widgets/custom_text.dart';
import 'package:flutter_achievments/features/auth/presentation/pages/login/login_page.dart';
import 'package:flutter_achievments/features/auth/presentation/pages/sign_up/terms_of_use_page.dart';

class AuthButtons extends StatelessWidget {
  const AuthButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyElevatedButton.green(
            
            width: 256,
            onPressed: () {
              Navigator.pushNamed(context, LoginPage.routeName);
            },
            child: const CustomText('Войти', fontSize: 16)),
        const SizedBox(height: 16),
        MyElevatedButton(
            width: 256,
            onPressed: () {
              // Navigator.pushNamed(context, TermsOfUsePage.routeName);
            },
            child: const CustomText('Регистрация ', fontSize: 16)),
      ],
    );
  }
}
