import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
  await initializeFirebaseEmulators();
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

Future<void> initializeFirebaseEmulators() async {
  await sl<FirebaseAuth>().useAuthEmulator('127.0.0.1', 9099);
  sl<FirebaseFirestore>().useFirestoreEmulator('127.0.0.1', 8080);
  sl<FirebaseFunctions>().useFunctionsEmulator('127.0.0.1', 5001);
  await sl<FirebaseStorage>().useStorageEmulator('127.0.0.1', 9199);
}
