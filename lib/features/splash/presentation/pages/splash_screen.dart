import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/constant/colors.dart';
import 'package:flutter_achievments/core/common/widgets/custom_text.dart';
import 'package:flutter_achievments/features/auth/presentation/pages/login/login_page.dart';
import 'package:flutter_achievments/features/splash/presentation/widgets/app_icon.dart';
import 'package:flutter_achievments/features/splash/presentation/widgets/splash_body.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = '/';
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return const Scaffold(
        body:  SplashBody());
  }
}
