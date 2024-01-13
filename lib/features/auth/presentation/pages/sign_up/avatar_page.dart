import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/common/widgets/custom_navbar.dart';
import 'package:flutter_achievments/features/auth/presentation/widgets/avatar_page_body.dart';

class AvatarPage extends StatelessWidget {
  const AvatarPage({super.key, required this.pageName});
  static const String routeName = '/avatar';
  final String pageName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomNavBar(pageName),
      body: const SafeArea(child: AvatarPageBody()),
    );
  }
}
