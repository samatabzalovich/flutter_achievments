// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:flutter_achievments/core/common/widgets/custom_navbar.dart';
import 'package:flutter_achievments/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter_achievments/features/profile/presentation/pages/avatar_page.dart';

import 'package:flutter_achievments/features/profile/presentation/widgets/parent_profile/account_pref_body.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountPrefPage extends StatelessWidget {
  const AccountPrefPage({
    Key? key,
  }) : super(key: key);
  static const String routeName = '/account_pref';
  @override
  Widget build(BuildContext context) {
    final appBar = CustomNavBar(
      '',
      onBackTapped: (_) {
        BlocProvider.of<AuthCubit>(context).signOut();
        Navigator.of(context).pop();
      },
    );
    return Scaffold(
      appBar: appBar,
      resizeToAvoidBottomInset: false,
      body: const AccountPrefBody(),
    );
  }
}
