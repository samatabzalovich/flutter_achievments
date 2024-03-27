import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/common/widgets/custom_text.dart';
import 'package:flutter_achievments/core/constant/colors.dart';

class CreatePageCustomNavBar extends StatelessWidget {
  const CreatePageCustomNavBar({super.key, required this.text});
  final String text;
void _pop(BuildContext context) {
    Navigator.pop(
      context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height /3.5,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 3],
            colors: [
              gradientColor,
              gradientColor2,
            ],
          ),
        ),
        child: SafeArea(
          top: true,
          bottom: false,
          child: AppBar(
              toolbarHeight: 30,
              leading: IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                  onPressed: () => _pop(context)),
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: CustomText(
                text,
                fontSize: 16,
                color: Colors.white,
              ),
              centerTitle: true,
            ),
        ),
      ),
    );
  }
}