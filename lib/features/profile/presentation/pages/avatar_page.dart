import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/common/avatar/avatar.dart';
import 'package:flutter_achievments/core/common/dialogs/show_error_dialog.dart';
import 'package:flutter_achievments/core/common/widgets/loading/loading_screen.dart';
import 'package:flutter_achievments/core/enums/user_type.dart';
import 'package:flutter_achievments/features/app/domain/shared_entities/parent_entity.dart';
import 'package:flutter_achievments/features/app/domain/shared_entities/user_entity.dart';
import 'package:flutter_achievments/core/common/widgets/custom_navbar.dart';
import 'package:flutter_achievments/features/app/presentation/provider/user_provider.dart';
import 'package:flutter_achievments/features/profile/presentation/pages/child_profile_page.dart';
import 'package:flutter_achievments/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:flutter_achievments/features/profile/presentation/widgets/common/avatar_page_body.dart';
import 'package:flutter_achievments/features/task/presentation/pages/home/parent_home_page.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class AvatarPage extends StatelessWidget {
  const AvatarPage(
      {super.key,
      required this.pageName,
      required this.user,
      this.userCredentials});
  static const String routeName = '/avatar';
  final String pageName;
  final UserEntity user;
  final Map<String, String>? userCredentials; // for child signUp

  @override
  Widget build(BuildContext context) {
    // TODO: add child profile listeners
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileStateLoading) {
          LoadingScreen.instance().show(context: context, text: '');
        }
        if (state is ProfileStateUpdated) {
          LoadingScreen.instance().hide();
          Provider.of<UserProvider>(context, listen: false).setUser(state.user);
          Navigator.of(context).pushNamed(ChildProfilePage.routeName);
        }
        if (state is ProfileStateChildCreated) {
          LoadingScreen.instance().hide();
          final user =
              (Provider.of<UserProvider>(context, listen: false).currentUser);
              final parent = user as ParentEntity;
          if (parent.children == null) {
            final parentProfile = parent.copyWith(children: [state.user]);
            Provider.of<UserProvider>(context, listen: false)
                .setUser(parentProfile);
          } else {
            final parentProfile =
                parent.copyWith(children: [...parent.children!, state.user]);
            Provider.of<UserProvider>(context, listen: false)
                .setUser(parentProfile);
          }
          Navigator.of(context).pushNamed(ParentHomePage.routeName);
        }
        if (state is ProfileStateLoadingProgress) {
          LoadingScreen.instance()
              .show(context: context, text: state.progress.toString());
        }
        if (state is ProfileStateError) {
          LoadingScreen.instance().hide();
          showErrorDialog(
              dialogText: state.dialogText,
              dialogTitle: state.dialogTitle,
              context: context);
        }
      },
      child: Scaffold(
        appBar: CustomNavBar(pageName),
        body: SafeArea(
            child: AvatarPageBody(
          childCredentials: userCredentials,
          userInfo: user,
        )),
      ),
    );
  }
}
