
import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/common/widgets/custom_navbar.dart';
import 'package:flutter_achievments/features/auth/presentation/widgets/sign_up_widgets/choose_type_body.dart';


class ChooseTypePage extends StatelessWidget {
  const ChooseTypePage({super.key});
  static const String routeName = '/choose_type';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomNavBar(''),
      body: SafeArea(
        child: ChooseTypeBody(),
      ),
    );
  }
}
