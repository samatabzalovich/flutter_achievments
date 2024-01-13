// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:flutter_achievments/core/common/widgets/custom_navbar.dart';
import 'package:flutter_achievments/features/app/domain/shared_entities/child_entity.dart';
import 'package:flutter_achievments/features/auth/presentation/widgets/sign_up_widgets/sign_up_child_body.dart';
import 'package:flutter_achievments/generated/locale_keys.g.dart';

class SignUpChildPage extends StatelessWidget {
  const SignUpChildPage({
    Key? key,
    required this.childProfile,
  }) : super(key: key);
  static const String routeName = '/sign_up_child';
  final ChildEntity childProfile;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomNavBar(LocaleKeys.adding_a_child),
      body: SignUpChildBody(childProfile),
    );
  }
}
