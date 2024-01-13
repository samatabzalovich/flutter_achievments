// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:flutter_achievments/core/enums/user_type.dart';
import 'package:flutter_achievments/core/common/widgets/custom_navbar.dart';
import 'package:flutter_achievments/features/auth/presentation/widgets/sign_up_body.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage(
    this.userType, {
    Key? key,
  }) : super(key: key);
  final UserType userType;
  static const String routeName = '/sign_up';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomNavBar(''),
        body: SafeArea(child: SignUpBody(userType)));
  }
}
