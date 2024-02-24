import 'package:flutter/material.dart';
import 'package:flutter_achievments/features/splash/presentation/widgets/splash_body.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

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
