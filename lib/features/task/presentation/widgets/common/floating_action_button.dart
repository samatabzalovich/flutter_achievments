import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/common/widgets/custom_text_no_tr.dart';
import 'package:flutter_achievments/core/constant/colors.dart';
import 'package:flutter_achievments/features/task/presentation/pages/common/choose_category_task_page.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [greenButtonGradient, greenButtonGradient2],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          boxShadow: [
            BoxShadow(
              color: buttonGreenShadow,
              offset: Offset(0, 4),
              blurRadius: 4,
            ),
          ]),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: FloatingActionButton(
          elevation: 0,
          onPressed: () {
            Navigator.of(context).pushNamed(ChooseCategoryTaskPage.routeName);
          },
          splashColor: Colors.lightGreen,
          highlightElevation: 0,
          backgroundColor: Colors.transparent,
          child: const Stack(alignment: Alignment.center, children: [
            CustomTextNoTr(
              '+',
              fontWeight: FontWeight.w700,
              color: Colors.white,
              fontSize: 50,
            )
          ]),
        ),
      ),
    );
  }
}
