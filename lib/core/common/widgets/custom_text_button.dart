import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/constant/colors.dart';
import 'package:flutter_achievments/core/common/widgets/custom_text.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton(this.text,
      {super.key,
      required this.onPressed,
      this.width,
      this.height = 48,
      this.backgroundColor,this.textColor = borderBlueColor});
  final VoidCallback onPressed;
  final double? width;
  final double height;
  final String text;
  final Color? backgroundColor;
  final Color textColor;
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: Colors.blue.withOpacity(0.1),
        fixedSize: Size(width ?? double.infinity, height),
        side: const BorderSide(color: borderBlueColor),
      ),
      child: CustomText(
        text,
        color: textColor,
        overflow: TextOverflow.ellipsis,
        fontSize: 15,
      ),
    );
  }
}
