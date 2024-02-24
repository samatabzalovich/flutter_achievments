import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/constant/colors.dart';


class CustomTextNoTr extends StatelessWidget {
  const CustomTextNoTr(
    this.text, {
    Key? key,
    this.fontSize = 16,
    this.fontWeight = FontWeight.w700,
    this.textAlign = TextAlign.center,
    this.color = Colors.white,
    this.letterSpacing = 0,
    this.overflow = TextOverflow.visible,
  }) : super(key: key);
  const CustomTextNoTr.darkBlueTitle(
    this.text, {
    Key? key,
    this.fontSize = 20,
    this.fontWeight = FontWeight.w700,
    this.textAlign = TextAlign.center,
    this.color = darkBlue,
    this.letterSpacing = 0,
    this.overflow = TextOverflow.visible,
  }) : super(key: key);
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final Color? color;
  final double letterSpacing;
  final TextOverflow overflow;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: overflow,

      style: Theme.of(context).textTheme.titleMedium!.copyWith(
          fontSize: fontSize,
          color: color,
          fontWeight: fontWeight,
          letterSpacing: letterSpacing),
    );
  }
}
