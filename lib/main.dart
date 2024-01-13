import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/constant/colors.dart';
import 'package:flutter_achievments/core/enums/user_type.dart';
import 'package:flutter_achievments/features/auth/presentation/pages/sign_up/account_pref_page.dart';
import 'package:flutter_achievments/features/auth/presentation/pages/sign_up/avatar_page.dart';
import 'package:flutter_achievments/features/auth/presentation/pages/sign_up/choose_type_page.dart';
import 'package:flutter_achievments/features/auth/presentation/pages/sign_up/sign_up_child_page.dart';
import 'package:flutter_achievments/features/auth/presentation/pages/sign_up/sign_up_page.dart';
import 'package:flutter_achievments/features/auth/presentation/pages/sign_up/terms_of_use_page.dart';
import 'package:flutter_achievments/features/splash/presentation/pages/splash_screen.dart';
import 'package:flutter_achievments/generated/codegen_loader.g.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(
    EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('ru')],
        path:
            'assets/translations', // <-- change the path of the translation files
        assetLoader: const CodegenLoader(),
        fallbackLocale: const Locale('en'),
        child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: 'Flutter Demo',
      theme: ThemeData(
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
      home: const SplashScreen(),
    );
  }
}
