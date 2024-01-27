import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/enums/user_type.dart';
import 'package:flutter_achievments/features/app/domain/shared_entities/user_entity.dart';
import 'package:flutter_achievments/features/app/presentation/provider/user_provider.dart';
import 'package:flutter_achievments/features/profile/presentation/pages/account_pref_page.dart';
import 'package:flutter_achievments/features/profile/presentation/pages/child_profile_page.dart';
import 'package:flutter_achievments/features/task/presentation/pages/home/child_home_page.dart';
import 'package:flutter_achievments/features/task/presentation/pages/home/parent_home_page.dart';
import 'package:provider/provider.dart';

void navigateUserBasedOnType(UserEntity user, BuildContext context) {
  Provider.of<UserProvider>(context, listen: false)
              .setUser(user);
    if (user.userType == UserType.parent) {
      if (user.name == null) {
        Navigator.of(context).pushNamed(AccountPrefPage.routeName);
      } else {
        Navigator.of(context).pushNamedAndRemoveUntil(ParentHomePage.routeName, (route) => false);
      }
    } else {
      if (user.name == null) {
        Navigator.of(context).pushNamed(ChildProfilePage.routeName);
      } else {
        Navigator.of(context).pushNamedAndRemoveUntil(ChildHomePage.routeName, (route) => false);
      }
    }
}