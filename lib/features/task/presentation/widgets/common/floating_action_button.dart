import 'package:flutter/material.dart';
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
            Navigator.of(context).pushNamed(
              ChooseCategoryTaskPage.routeName
            );
          },
          splashColor: Colors.lightGreen,
          highlightElevation: 0,
          backgroundColor: Colors.transparent,
          child: const Stack(alignment: Alignment.center, children: [
            SizedBox(
              width: 25,
              height: 6,
              child: DecoratedBox(
                decoration: BoxDecoration(
                    // inner shadow
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(7, 73, 32, 0.25),
                      ),
                      BoxShadow(
                        color: Colors.white,
                        spreadRadius: 0,
                        blurRadius: 2.0,
                        offset: Offset(0, 3),
                      ),
                    ]),
              ),
            ),
            SizedBox(
              width: 6,
              height: 25,
              child: DecoratedBox(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(7, 73, 32, 0.25),
                  ),
                  BoxShadow(
                      color: Colors.white,
                      spreadRadius: 0,
                      blurRadius: 2.0,
                      offset: Offset(0, 4),
                      blurStyle: BlurStyle.inner),
                ]),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
