// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/common/dialogs/show_error_dialog.dart';
import 'package:flutter_achievments/core/common/widgets/loading/loading_screen.dart';

import 'package:flutter_achievments/core/enums/user_type.dart';
import 'package:flutter_achievments/core/common/widgets/custom_navbar.dart';
import 'package:flutter_achievments/features/app/presentation/provider/user_provider.dart';
import 'package:flutter_achievments/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter_achievments/features/profile/presentation/pages/account_pref_page.dart';
import 'package:flutter_achievments/features/auth/presentation/widgets/sign_up_widgets/sign_up_body.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage(
    this.userType, {
    Key? key,
  }) : super(key: key);
  final UserType userType;
  static const String routeName = '/sign_up';

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthStateLoading) {
          LoadingScreen.instance().show(context: context, text: '');
        }
        if (state is AuthStateSuccess) {
          Provider.of<UserProvider>(context, listen: false).setUser(state.userEntity!);
          LoadingScreen.instance().hide();
          Navigator.pushNamed(
            context,
              AccountPrefPage.routeName, );
        }
        if (state is AuthStateError) {
          LoadingScreen.instance().hide();
          showErrorDialog(
              dialogText: state.dialogText,
              dialogTitle: state.dialogTitle,
              context: context);
        }
      },
      child: Scaffold(
          appBar: const CustomNavBar(''),
          body: SafeArea(child: SignUpBody(userType))),
    );
  }
}
