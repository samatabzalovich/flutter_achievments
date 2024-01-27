import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/constant/colors.dart';
import 'package:flutter_achievments/core/common/widgets/custom_text.dart';

class LinearGradNavbar<T> extends StatelessWidget implements PreferredSizeWidget {
  const LinearGradNavbar(this.text, {
    super.key, 
    this.data,
    this.onBackTapped
  });
  final String text;
  final T? data;
  final Function(dynamic data)? onBackTapped;
  void _pop(BuildContext context) {
              Navigator.pop(context, data);
            }
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0,3],
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
            onPressed: onBackTapped == null ?  () => _pop(context) :() => onBackTapped!(data),
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
