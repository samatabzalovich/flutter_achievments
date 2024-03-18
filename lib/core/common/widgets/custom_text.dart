import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/constant/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomText extends StatelessWidget {
  const CustomText(
    this.text, {
    Key? key,
    this.fontSize = 16,
    this.fontWeight = FontWeight.w700,
    this.textAlign = TextAlign.center,
    this.color = Colors.white,
    this.letterSpacing = 0,
    this.overflow = TextOverflow.visible,
  }) : super(key: key);
  const CustomText.darkBlueTitle(
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
          fontSize: ScreenUtil().setSp(fontSize * customScaleFactor(context)),
          color: color,
          
          fontWeight: fontWeight,
          letterSpacing: letterSpacing, height: 1),
    ).tr();
  }

  double customScaleFactor(BuildContext context) {
  var isTablet = MediaQuery.of(context).size.shortestSide > 600;
  return isTablet ? 0.6 : 1.0; // Example adjustment, customize as needed
}
}
