
import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/common/widgets/animated_custom_button.dart';
import 'package:flutter_achievments/core/common/widgets/custom_button.dart';
import 'package:flutter_achievments/core/common/widgets/custom_text.dart';
import 'package:flutter_achievments/core/common/widgets/custom_text_button.dart';

class TextAndGreenButtons extends StatelessWidget {
  const TextAndGreenButtons({
    super.key, required this.textPressed, required this.greenPressed, required this.blueText, required this.greenText,
  });
  final VoidCallback textPressed;
  final VoidCallback greenPressed;
  final String blueText;
  final String greenText;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomTextButton(
          blueText,
          backgroundColor: Colors.white,
          width: MediaQuery.of(context).size.width /2.3,
          onPressed: textPressed,),
        MyElevatedButton.green(
          height: 48,
          width: MediaQuery.of(context).size.width /2.3,
          onPressed: greenPressed, child:  CustomText(greenText),)
      ],
    );
  }
}

class AnimatedTextAndGreenButtons extends StatelessWidget {
  const AnimatedTextAndGreenButtons({
    super.key, required this.textPressed, required this.greenPressed, required this.blueText, required this.greenText,
    required this.controller,
  });
  final VoidCallback textPressed;
  final VoidCallback greenPressed;
  final String blueText;
  final String greenText;
  final AnimationController controller;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomTextButton(
          blueText,
          backgroundColor: Colors.white,
          width: MediaQuery.of(context).size.width /2.3,
          onPressed: textPressed,),
          AnimatedCustomButton(greenText, controller: controller, width: MediaQuery.of(context).size.width /2.3,height: 48, onPressed: greenPressed,)
      ],
    );
  }
}