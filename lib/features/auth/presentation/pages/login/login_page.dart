import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/common/widgets/animated_custom_button.dart';
import 'package:flutter_achievments/core/common/widgets/custom_button.dart';
import 'package:flutter_achievments/core/common/widgets/custom_navbar.dart';
import 'package:flutter_achievments/core/common/widgets/custom_text_field.dart';
import 'package:flutter_achievments/core/common/widgets/social_media.dart';
import 'package:flutter_achievments/core/constant/colors.dart';
import 'package:flutter_achievments/core/routes/custom_page_builder.dart';
import 'package:flutter_achievments/core/common/widgets/custom_text.dart';
import 'package:flutter_achievments/features/auth/presentation/pages/login/login_page.dart';
import 'package:flutter_achievments/features/auth/presentation/widgets/login_widgets/login_body.dart';
import 'package:flutter_achievments/features/splash/presentation/widgets/app_icon.dart';
import 'package:flutter_achievments/generated/locale_keys.g.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  static const String routeName = '/login';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
        appBar: CustomNavBar(LocaleKeys.signInAppBarTitle), body: LoginBody());
  }
}
