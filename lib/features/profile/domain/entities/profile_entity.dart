// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:flutter_achievments/features/app/domain/shared_entities/user_entity.dart';

class ProfileEntity extends Equatable {
  final String? avatarUrl;
  final UserEntity user;
  final Sink<int>? progress;
  const ProfileEntity({
    this.avatarUrl,
    required this.user,
    this.progress,
  });

  @override
  List<Object?> get props => [avatarUrl, user];
}
