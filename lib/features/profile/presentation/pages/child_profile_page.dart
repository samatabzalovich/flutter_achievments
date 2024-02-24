// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:flutter_achievments/core/common/widgets/custom_navbar.dart';
import 'package:flutter_achievments/features/profile/presentation/widgets/child_profile/child_profile_body.dart';

class ChildProfilePage extends StatelessWidget {
  const ChildProfilePage({
    Key? key,
  }) : super(key: key);
  static const String routeName = '/child-profile';
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomNavBar(''),
      body: ChildProfileBody(),
    );
  }
}
