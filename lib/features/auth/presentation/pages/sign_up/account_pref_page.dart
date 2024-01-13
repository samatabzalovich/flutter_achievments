// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:flutter_achievments/core/common/widgets/custom_navbar.dart';

import 'package:flutter_achievments/features/auth/presentation/widgets/account_pref_body.dart';

class AccountPrefPage extends StatelessWidget {
  const AccountPrefPage({
    Key? key,
    required this.userInfo,
  }) : super(key: key);
  static const String routeName = '/account_pref';
  final Map<String, dynamic> userInfo;
  @override
  Widget build(BuildContext context) {
    const appBar = CustomNavBar('');
    return Scaffold(
      appBar: appBar,
      resizeToAvoidBottomInset: false,
      body: AccountPrefBody(userInfo: userInfo),
    );
  }
}
