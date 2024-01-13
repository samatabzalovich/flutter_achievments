import 'dart:io' show File;

import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/enums/user_type.dart';
import 'package:flutter_achievments/core/services/get_it.dart';
import 'package:flutter_achievments/features/app/domain/shared_entities/child_entity.dart';
import 'package:flutter_achievments/features/app/domain/shared_entities/user_entity.dart';
import 'package:flutter_achievments/core/common/widgets/blue_green_buttons.dart';
import 'package:flutter_achievments/core/common/widgets/custom_button.dart';
import 'package:flutter_achievments/core/common/widgets/custom_text.dart';
import 'package:flutter_achievments/core/common/widgets/custom_text_button.dart';
import 'package:flutter_achievments/core/common/avatar/avatar.dart';
import 'package:flutter_achievments/features/app/presentation/provider/user_provider.dart';
import 'package:flutter_achievments/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter_achievments/features/profile/presentation/bloc/profile_event.dart';
import 'package:flutter_achievments/features/profile/presentation/pages/child_profile_page.dart';
import 'package:flutter_achievments/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:flutter_achievments/features/profile/presentation/widgets/common/select_avatar_form.dart';
import 'package:flutter_achievments/generated/locale_keys.g.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class AvatarPageBody extends StatelessWidget {
  const AvatarPageBody(
      {super.key, required this.userInfo, this.childCredentials});
  final UserEntity userInfo;
  final Map<String, String>? childCredentials;

  @override
  Widget build(BuildContext context) {
    final parentId = Provider.of<UserProvider>(context).currentUser?.id;
    AvatarEntity? avatar;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SelectAvatarForm(
              userName: userInfo.name!,
              onPicked: (pickedAvatar) {
                avatar = pickedAvatar;
              }),
          TextAndGreenButtons(
            blueText: LocaleKeys.skip,
            greenText: LocaleKeys.select,
            textPressed: () {
              if (userInfo.userType == UserType.parent) {
                context
                    .read<ProfileBloc>()
                    .add(ProfileEventUpdateProfile(userInfo.copyWith(
                      avatar: const NoneAvatarEntity(),
                    )));
              } else {
                if (childCredentials != null) {
                  context.read<ProfileBloc>().add(ProfileEventCreateChild(
                      user:
                          (userInfo as ChildEntity).copyWith(
                            email: childCredentials!['email'],
                            parentId: parentId,
                            ),
                      password: childCredentials!['password']!));
                } else {
                  context.read<ProfileBloc>().add(
                        ProfileEventCreateChildProfile(
                            (userInfo as ChildEntity).copyWith(
                              avatar: const NoneAvatarEntity(),
                              parentId: parentId,
                            ),
                            ''),
                      );
                }
              }
            },
            greenPressed: () {
                  if (userInfo.userType == UserType.parent) {
                context
                  .read<ProfileBloc>()
                  .add(ProfileEventUploadAvatarAndUpdateProfile(userInfo.copyWith(
                    avatar: avatar ?? const NoneAvatarEntity(),
                  )));
              } else {
                if (childCredentials != null) {
                  context.read<ProfileBloc>().add(ProfileEventCreateChild(
                      user:
                          (userInfo as ChildEntity).copyWith(email: childCredentials!['email'], avatar: avatar ?? const NoneAvatarEntity(),parentId: parentId,),
                      password: childCredentials!['password']!));
                } else {
                  context.read<ProfileBloc>().add(
                        ProfileEventCreateChildProfile(
                            (userInfo as ChildEntity).copyWith(
                              avatar: avatar ?? const NoneAvatarEntity(),
                              parentId: parentId,
                            ),
                            ''),
                      );
                }
              }
            },
          )
        ],
      ),
    );
  }
}
