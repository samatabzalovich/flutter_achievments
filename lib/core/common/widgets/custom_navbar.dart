import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/constant/colors.dart';
import 'package:flutter_achievments/core/common/widgets/custom_text.dart';

class CustomNavBar<T> extends StatelessWidget implements PreferredSizeWidget {
  const CustomNavBar(this.text, {
    super.key, 
    this. data
  });
  final String text;
  final T? data;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            radius: 1,
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
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white,),
            onPressed: () {
              Navigator.pop(context, data);
            },
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: CustomText(text, fontSize: 16, color: Colors.white,),
          centerTitle: true,
        ));
  }

  @override
  Size get preferredSize => const Size.fromHeight(40);
}
