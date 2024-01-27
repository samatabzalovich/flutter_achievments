import 'package:flutter_achievments/core/common/extensions/type_cast.dart';
import 'package:flutter_achievments/core/enums/user_type.dart';
import 'package:flutter_achievments/core/error/failure.dart';
import 'package:flutter_achievments/features/app/data/shared_models/child_model.dart';
import 'package:flutter_achievments/features/app/data/shared_models/parent_model.dart';
import 'package:flutter_achievments/features/app/data/shared_models/user_model.dart';
import 'package:flutter_achievments/features/app/domain/shared_entities/child_entity.dart';
import 'package:flutter_achievments/features/app/domain/shared_entities/parent_entity.dart';
import 'package:flutter_achievments/features/app/domain/shared_entities/user_entity.dart';
import 'package:flutter_achievments/features/profile/domain/entities/profile_entity.dart';

class ProfileModel extends ProfileEntity {
  final UserModel userModel;
  const ProfileModel({ super.avatarUrl, required this. userModel, super.progress}) : super(user: userModel);

  factory ProfileModel.fromEntity(ProfileEntity entity) {
    late final UserModel userModel ;
    if (entity.user.userType == UserType.parent) {
      userModel = ParentModel.fromEntity(entity.user as ParentEntity);
    } else {
      userModel = ChildModel.fromEntity(entity.user as ChildEntity);
    }
    return ProfileModel(
      avatarUrl: entity.avatarUrl,
      userModel: userModel,
      progress: entity.progress,
    );
  }

  

  ProfileModel copyWith({
    String? avatarUrl,
    UserModel? user,
    Sink<int>? progress,
  }) {
    return ProfileModel(
      avatarUrl: avatarUrl ?? this.avatarUrl,
      userModel: user ?? userModel,
      progress: progress ?? this.progress,
    );
  }
}
