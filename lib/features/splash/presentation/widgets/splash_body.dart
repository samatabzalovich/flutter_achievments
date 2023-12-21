import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/constant/colors.dart';
import 'package:flutter_achievments/core/router/custom_page_builder.dart';
import 'package:flutter_achievments/core/widgets/custom_text.dart';
import 'package:flutter_achievments/features/splash/presentation/widgets/app_icon.dart';
import 'package:flutter_achievments/features/splash/presentation/widgets/form_section.dart';
import 'package:flutter_achievments/features/splash/presentation/widgets/stars_icon.dart';

class SplashBody extends StatefulWidget {
  const SplashBody({super.key});

  @override
  State<SplashBody> createState() => _SplashBodyState();
}

class _SplashBodyState extends State<SplashBody> with TickerProviderStateMixin {
  late AnimationController _splashAnimationController;
  late Animation<double> _backgroundAnimation;
  late Animation<double> _titleAnimation;

  late AnimationController _formAnimationController;
  late Animation<double> _formAnimation;
  late Animation<double> _opacityAnimation;
  @override
  void initState() {
    super.initState();
    _splashAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _backgroundAnimation = Tween<double>(begin: 0, end: 2).animate(
        CurvedAnimation(
            parent: _splashAnimationController, curve: Curves.decelerate));
    _titleAnimation = Tween<double>(begin: 0.15, end: 0.80).animate(
        CurvedAnimation(
            parent: _splashAnimationController, curve: Curves.decelerate));

    _formAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _splashAnimationController.addListener(() {
      if (_splashAnimationController.isCompleted) {
        _formAnimationController.forward();
      }
    });
    _formAnimation = Tween<double>(begin: -300, end: 0).animate(CurvedAnimation(
        parent: _formAnimationController, curve: Curves.decelerate));
        _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _formAnimationController, curve: Curves.decelerate));
  }

  @override
  void dispose() {
    _splashAnimationController.dispose();
    _formAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: AnimatedBuilder(
          animation: Listenable.merge([
            _splashAnimationController,
            _formAnimationController
          ]),
          builder: (context, _) {
            return Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: MediaQuery.of(context).size.height /
                            _backgroundAnimation.value -
                        30,
                    decoration: const BoxDecoration(
                      gradient: RadialGradient(
                        colors: [gradientColor, gradientColor2],
                        radius: 0.5,
                        center: Alignment.center,
                      ),
                    ),
                  ),
                ),
                Positioned(
                    bottom: MediaQuery.of(context).size.height / 2 - 20,
                    child: AppIcon(
                      controller: _formAnimationController,
                    )),
                Positioned(
                  bottom: MediaQuery.of(context).size.height *
                      _titleAnimation.value,
                  child: GestureDetector(
                    onTap: () {
                      _splashAnimationController.forward();
                    },
                    child: const Column(
                      children: [
                        CustomText(
                          'Достигай!',
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                        ),
                        CustomText(
                          'Веселись! Получай награды!',
                          fontSize: 16,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: _formAnimation.value,
                  child: Opacity(opacity: _opacityAnimation.value,child: FormSection()),
                ),
              ],
            );
          }),
    );
  }
}
