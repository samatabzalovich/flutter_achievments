import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/constant/colors.dart';
import 'package:flutter_achievments/core/routes/router.dart';
import 'package:flutter_achievments/features/app/presentation/provider/user_provider.dart';
import 'package:flutter_achievments/features/auth/presentation/pages/login/login_page.dart';
import 'package:flutter_achievments/features/auth/presentation/pages/sign_up/sign_up_child_page.dart';
import 'package:flutter_achievments/features/profile/presentation/pages/child_profile_page.dart';
import 'package:flutter_achievments/features/profile/presentation/pages/account_pref_page.dart';
import 'package:flutter_achievments/features/profile/presentation/pages/choose_type_page.dart';
import 'package:flutter_achievments/features/auth/presentation/pages/sign_up/sign_up_page.dart';
import 'package:flutter_achievments/features/splash/presentation/pages/splash_screen.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return ChangeNotifierProvider(
      create: (_) => UserProvider(),
      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        title: 'Flutter Demo',
        theme: ThemeData(
          dialogBackgroundColor: Colors.white,
          indicatorColor: lightBlue,
          fontFamily: 'Montserrat',
          textTheme: const TextTheme(
              titleMedium: TextStyle(
            fontWeight: FontWeight.bold,
          )),
          colorScheme: ColorScheme.fromSeed(seedColor: borderBlueColor),
          useMaterial3: true,
          scaffoldBackgroundColor: scaffoldBackground,
        ),
        // onGenerateRoute: onGenerateRoutes,
        onGenerateRoute: onGenerateRoutes,
      ),
    );
  }
}
