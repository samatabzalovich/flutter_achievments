import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/constant/colors.dart';
import 'package:flutter_achievments/core/routes/router.dart';
import 'package:flutter_achievments/features/app/presentation/provider/app_lifecycle_cache.dart';
import 'package:flutter_achievments/features/app/presentation/provider/selected_user_provider.dart';
import 'package:flutter_achievments/features/app/presentation/provider/user_provider.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => SelectedUserProvider()),
        Provider(create: (_) => LoginLifeCycleCache()),
      ],
      child: ScreenUtilInit(
        
        designSize: const Size(428, 926),
      minTextAdapt: true,
      
      splitScreenMode: true,
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
      ),
    );
  }
}
