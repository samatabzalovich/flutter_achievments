import 'package:flutter_achievments/core/enums/reward_type.dart';
import 'package:flutter_achievments/features/task/data/models/shared/category_model.dart';
import 'package:flutter_achievments/features/task/domain/entities/reward_entities/reward_entity.dart';

class RewardModel extends RewardEntity {
  const RewardModel({
    required String id,
    required String name,
    required DateTime createdAt,
    required DateTime updatedAt,
    required CategoryModel category,
    required bool isInfinite,
    required int cost,
    required int? available,
    required List<String> children,
    required String createdBy,
    required RewardType type,
  }) : super(
          id: id,
          name: name,
          createdAt: createdAt,
          updatedAt: updatedAt,
          category: category,
          isInfinite: isInfinite,
          cost: cost,
          available: available,
          children: children,
          createdBy: createdBy,
          type: type,
        );

  factory RewardModel.fromMap(Map<String, dynamic> map) {
    return RewardModel(
      id: map['id'],
      name: map['name'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
      category: map['category'],
      isInfinite: map['isInfinite'],
      cost: map['cost'],
      available: map['available'],
      children: map['children'],
      createdBy: map['createdBy'],
      type: map['type'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'category': category,
      'isInfinite': isInfinite,
      'cost': cost,
      'available': available,
      'children': children,
      'createdBy': createdBy,
      'type': type,
    };
  }
}