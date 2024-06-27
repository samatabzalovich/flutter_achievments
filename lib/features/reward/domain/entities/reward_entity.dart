// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart' show Color;
import 'package:flutter_achievments/core/common/avatar/avatar.dart';
import 'package:flutter_achievments/core/common/avatar/frame_avatar.dart';
import 'package:flutter_achievments/core/enums/reward_type.dart';
import 'package:flutter_achievments/features/task/domain/entities/shared/category_entity.dart';

class RewardEntity extends Equatable {
  final String id;
  final String name;
  final String? description;
  final int cost;
  final FrameAvatarEntity avatar;
  final CategoryEntity category;
  final bool isInfinite;
  final int? available;
  final bool isCommonReward;
  final List<String> receivers;
  final RewardType type;
  final String createdBy;
  final DateTime createdAt;
  final String parentId;
  final DateTime updatedAt;
  const RewardEntity({
    required this.id,
    required this.name,
    this.description,
    required this.cost,
    required this.avatar,
    required this.category,
    required this.isInfinite,
    this.available,
    required this.isCommonReward,
    required this.receivers,
    required this.type,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    required this.parentId,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        cost,
        avatar,
        category,
        isInfinite,
        available,
        isCommonReward,
        receivers,
        type,
        createdBy,
        createdAt,
        updatedAt,
        parentId
      ];

  RewardEntity copyWith({
    String? id,
    String? name,
    String? description,
    int? cost,
    FrameAvatarEntity? avatar,
    CategoryEntity? category,
    bool? isInfinite,
    int? available,
    bool? isCommonReward,
    List<String>? receivers,
    RewardType? type,
    String? createdBy,
    DateTime? createdAt,
    String? parentId,
    DateTime? updatedAt,
  }) {
    return RewardEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      cost: cost ?? this.cost,
      avatar: avatar ?? this.avatar,
      category: category ?? this.category,
      isInfinite: isInfinite ?? this.isInfinite,
      available: available ?? this.available,
      isCommonReward: isCommonReward ?? this.isCommonReward,
      receivers: receivers ?? this.receivers,
      type: type ?? this.type,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      parentId: parentId ?? this.parentId,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  static RewardEntity mock() {
    return RewardEntity(
      id: '1',
      name: 'Reward',
      description: 'Reward description',
      cost: 10,
      avatar: const FrameAvatarEntity(
          avatar: NoneAvatarEntity(),
          backgroundColor: Color.fromARGB(255, 161, 206, 122)),
      category: CategoryEntity.defaultRewardCategories()[0],
      isInfinite: false,
      available: 10,
      isCommonReward: false,
      receivers: const [],
      type: RewardType.available,
      createdBy: '1',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      parentId: '1',
      updatedAt: DateTime.now(),
    );
  }
}
