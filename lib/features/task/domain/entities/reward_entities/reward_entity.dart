// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter_achievments/core/enums/reward_type.dart';

import 'package:flutter_achievments/core/enums/user_type.dart';
import 'package:flutter_achievments/features/app/domain/shared_entities/child_entity.dart';
import 'package:flutter_achievments/features/task/domain/entities/shared/category_entity.dart';

class RewardEntity extends Equatable {
  final String id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;
  final CategoryEntity category;
  final bool isInfinite;
  final int cost;
  final int? available;
  final List<ChildEntity> children;
  final String createdBy;
  final RewardType type;
  const RewardEntity({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.category,
    required this.isInfinite,
    required this.cost,
    this.available,
    required this.children,
    required this.createdBy,
    required this.type,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        createdAt,
        category,
        isInfinite,
        cost,
        children,
        available,
        createdBy,
        type,
      ];
}
