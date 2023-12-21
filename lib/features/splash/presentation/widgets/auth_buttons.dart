import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/constant/colors.dart';
import 'package:flutter_achievments/core/widgets/custom_button.dart';
import 'package:flutter_achievments/core/widgets/custom_text.dart';

class AuthButtons extends StatelessWidget {
  const AuthButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyElevatedButton(
            gradient: const LinearGradient(
                colors: [greenButtonGradient2, greenButtonGradient],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter),
            width: 256,
            onPressed: () {},
            child: const CustomText('Войти', fontSize: 16)),
        const SizedBox(height: 16),
        MyElevatedButton(
            width: 256,
            onPressed: () {},
            child: const CustomText('Регистрация ', fontSize: 16)),
      ],
    );
  }
}
