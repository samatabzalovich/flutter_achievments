import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/constant/colors.dart';
import 'package:flutter_achievments/core/common/widgets/custom_text.dart';
import 'package:flutter_achievments/core/services/get_it.dart';
import 'package:flutter_achievments/features/app/presentation/helper/navigator_user_helper.dart';
import 'package:flutter_achievments/features/splash/presentation/bloc/auth_status.dart';
import 'package:flutter_achievments/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:flutter_achievments/features/splash/presentation/bloc/system_time_status.dart';
import 'package:flutter_achievments/features/splash/presentation/widgets/app_icon.dart';
import 'package:flutter_achievments/features/splash/presentation/widgets/form_section.dart';

class SplashBody extends StatefulWidget {
  const SplashBody({super.key});

  @override
  State<SplashBody> createState() => _SplashBodyState();
}

class _SplashBodyState extends State<SplashBody> with TickerProviderStateMixin {
  late final SplashBloc splashBloc;
  StreamSubscription<AuthStatus>? splashSub;
  StreamSubscription<SystemTimeStatus>? settingsSub;
  late AnimationController _initializeAnimationController;
  late AnimationController _splashAnimationController;
  late AnimationController _formAnimationController;

  late Animation<double> _backgroundOpacityAnimation;
  late Animation<double> _titleAnimation;
  late Animation<double> _textOpacityAnimation;
  late Animation<double> _iconAnimation;
  late Animation<double> _backgroundAnimation;
  late Animation<double> _formAnimation;
  late Animation<double> _opacityAnimation;
  @override
  void initState() {
    super.initState();
    splashBloc = sl<SplashBloc>();
    _initializeAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));
    _backgroundOpacityAnimation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
            parent: _initializeAnimationController,
            curve: const Interval(0, 0.7, curve: Curves.decelerate)));
    _textOpacityAnimation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
            parent: _initializeAnimationController,
            curve: const Interval(0.7, 1, curve: Curves.easeInQuint)));
    _iconAnimation = Tween<double>(begin: 0, end: 80).animate(CurvedAnimation(
        parent: _initializeAnimationController,
        curve: const Interval(0, 0.7, curve: Curves.bounceOut)));
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
    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: _formAnimationController, curve: Curves.decelerate));

    // _initializeAnimationController.addListener(() {

    // });

    listenToEvents();
  }

  @override
  void dispose() {
    _initializeAnimationController.dispose();
    _splashAnimationController.dispose();
    _formAnimationController.dispose();
    splashSub?.cancel();
    settingsSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: AnimatedBuilder(
          animation: Listenable.merge([
            _splashAnimationController,
            _formAnimationController,
            _initializeAnimationController
          ]),
          builder: (context, _) {
            return Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: ColoredBox(
                    color: splashScaffoldBackground,
                    child: FadeTransition(
                      opacity: _backgroundOpacityAnimation,
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
                  ),
                ),
                Positioned(
                  bottom: MediaQuery.of(context).size.height / 2 -
                      100 +
                      _iconAnimation.value /* + 80 */,
                  child: AppIcon(
                    formAnimationController: _formAnimationController,
                    iconAnimationController: _initializeAnimationController,
                  ),
                ),
                Positioned(
                  bottom: MediaQuery.of(context).size.height *
                      _titleAnimation.value,
                  child: FadeTransition(
                    opacity: _textOpacityAnimation,
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
                  child: Opacity(
                      opacity: _opacityAnimation.value,
                      child: const FormSection()),
                ),
              ],
            );
          }),
    );
  }

  void listenToEvents() async {
    await _initializeAnimationController.forward();
    splashSub = splashBloc.authStatus.listen((event) {
      if (event is AuthStatusLoggedOut) {
        Timer(const Duration(milliseconds: 1000), () {
          _splashAnimationController.forward();
        });
      } else if (event is AuthStatusLoggedIn) {
        navigateUserBasedOnType(event.userEntity!, context);
      }
    });
  }
}
