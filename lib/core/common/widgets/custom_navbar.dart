import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/common/widgets/custom_text.dart';
import 'package:flutter_achievments/core/common/widgets/custom_text_no_tr.dart';
import 'package:flutter_achievments/core/constant/colors.dart';

class CustomNavBar<T> extends StatelessWidget implements PreferredSizeWidget {
  const CustomNavBar(this.text,
      {super.key,
      this.data,
      this.onBackTapped,
      this.withTr = true,
      this.navbarBackButtonIncluded = true, this.isAnimationStarted = false});
  final String text;
  final bool navbarBackButtonIncluded;
  final T? data;
  final Function(dynamic data)? onBackTapped;
  final bool isAnimationStarted;
  final bool withTr;
  void _pop(BuildContext context) {
    Navigator.pop(context, data);
  }

  @override
  Widget build(BuildContext context) {
    final translated = withTr
        ? CustomText(
            text,
            fontSize: 16,
            color: Colors.white,
          )
        : CustomTextNoTr(
            text,
            fontSize: 16,
            color: Colors.white,
          );
    return Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            radius: 6,
            center: Alignment.topCenter,
            focalRadius: 0,
            colors: [
              gradientColor,
              gradientColor2,
            ],
          ),
        ),
        child: AppBar(
          leading: IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            icon: Icon(
              navbarBackButtonIncluded
                  ? Icons.arrow_back_ios
                  : isAnimationStarted ? CupertinoIcons.fullscreen_exit :CupertinoIcons.fullscreen,
              color: Colors.white,
            ),
            onPressed: onBackTapped == null
                ? () => _pop(context)
                : () => onBackTapped!(data),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: translated,
          centerTitle: true,
        ));
  }

  @override
  Size get preferredSize => const Size.fromHeight(40);
}
