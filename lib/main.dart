import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/services/get_it.dart';
import 'package:flutter_achievments/features/app/presentation/pages/app.dart';
import 'package:flutter_achievments/firebase_options.dart';
import 'package:flutter_achievments/generated/codegen_loader.g.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  await initializeDependencies();
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
