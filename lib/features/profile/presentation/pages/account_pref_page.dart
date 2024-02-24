// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:flutter_achievments/core/common/widgets/custom_navbar.dart';
import 'package:flutter_achievments/core/common/widgets/loading/loading_screen.dart';
import 'package:flutter_achievments/features/auth/presentation/cubit/auth_cubit.dart';

import 'package:flutter_achievments/features/profile/presentation/widgets/parent_profile/account_pref_body.dart';
import 'package:flutter_achievments/generated/locale_keys.g.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountPrefPage extends StatelessWidget {
  final VoidCallback? onBackTapped;
  final VoidCallback? navigator;
  const AccountPrefPage({
    Key? key,
    this.onBackTapped,
    this.navigator,
  }) : super(key: key);
  static const String routeName = '/account_pref';
  @override
  Widget build(BuildContext context) {
    final appBar = CustomNavBar(
      '',
      onBackTapped: (_) {
        BlocProvider.of<AuthCubit>(context).signOut();
      },
    );
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthStateLoading) {
          LoadingScreen.instance()
              .show(context: context, text: LocaleKeys.signingOut);
        }
        if (state is AuthStateSuccess) {
          LoadingScreen.instance().hide();
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        appBar: appBar,
        resizeToAvoidBottomInset: false,
        body: const AccountPrefBody(),
      ),
    );
  }
}
