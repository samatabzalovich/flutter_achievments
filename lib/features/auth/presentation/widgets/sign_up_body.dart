import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/enums/user_type.dart';

import 'package:flutter_achievments/core/common/widgets/social_media.dart';
import 'package:flutter_achievments/features/auth/presentation/widgets/sign_up_form.dart';

class SignUpBody extends StatefulWidget {
  const SignUpBody(
    this.userType, {
    super.key,
  });
  final UserType userType;
  @override
  State<SignUpBody> createState() => _SignUpBodyState();
}

class _SignUpBodyState extends State<SignUpBody> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SignUpForm(widget.userType),
            SizedBox(height: MediaQuery.of(context).size.height / 6),
            const SocialMedia(),
          ],
        ),
      ),
    );
  }
}
