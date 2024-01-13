import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/common/widgets/custom_navbar.dart';
import 'package:flutter_achievments/features/auth/presentation/widgets/sign_up_child_body.dart';

class SignUpChildPage extends StatelessWidget {
  const SignUpChildPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomNavBar(''),
      body: SignUpChildBody(),
    );
  }
}
