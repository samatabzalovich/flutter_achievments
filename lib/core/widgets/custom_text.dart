// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText(
    this.text, {
    Key? key,
    required this.fontSize,
     this.fontWeight = FontWeight.w700,
    this.textAlign = TextAlign.center,
    this.color = Colors.white,
  }) : super(key: key);
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      softWrap: true,
      style: Theme.of(context).textTheme.titleMedium!.copyWith(
  fontSize: fontSize,
  color: color,
  fontWeight: fontWeight),
    );
  }
}
