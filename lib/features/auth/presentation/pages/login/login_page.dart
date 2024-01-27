import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/common/dialogs/show_error_dialog.dart';
import 'package:flutter_achievments/core/common/widgets/custom_navbar.dart';
import 'package:flutter_achievments/core/common/widgets/loading/loading_screen.dart';
import 'package:flutter_achievments/core/enums/user_type.dart';
import 'package:flutter_achievments/features/app/domain/shared_entities/user_entity.dart';
import 'package:flutter_achievments/features/app/presentation/helper/navigator_user_helper.dart';
import 'package:flutter_achievments/features/app/presentation/provider/user_provider.dart';
import 'package:flutter_achievments/features/auth/presentation/cubit/auth_cubit.dart';

import 'package:flutter_achievments/features/auth/presentation/widgets/login_widgets/login_body.dart';
import 'package:flutter_achievments/features/profile/presentation/pages/account_pref_page.dart';
import 'package:flutter_achievments/features/profile/presentation/pages/child_profile_page.dart';
import 'package:flutter_achievments/features/task/presentation/pages/home/parent_home_page.dart';
import 'package:flutter_achievments/generated/locale_keys.g.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  static const String routeName = '/login';

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthStateLoading) {
          LoadingScreen.instance().show(context: context, text: '');
        }
        if (state is AuthStateSuccess) {
          Provider.of<UserProvider>(context, listen: false)
              .setUser(state.userEntity!);
          LoadingScreen.instance().hide();
          navigateUserBasedOnType(state.userEntity!, context);
        }
        if (state is AuthStateError) {
          LoadingScreen.instance().hide();
          showErrorDialog(
              dialogText: state.dialogText,
              dialogTitle: state.dialogTitle,
              context: context);
        }
      },
      child: const Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomNavBar(LocaleKeys.signInAppBarTitle),
        body: LoginBody(),
      ),
    );
  }
}
