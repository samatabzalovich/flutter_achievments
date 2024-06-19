import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_achievments/core/common/avatar/frame_avatar.dart';
import 'package:flutter_achievments/core/enums/reward_type.dart';
import 'package:flutter_achievments/features/reward/domain/entities/reward_entity.dart';
import 'package:flutter_achievments/features/task/data/models/shared/category_model.dart';

class RewardModel extends RewardEntity {
  const RewardModel(
      {required super.id,
      required super.name,
      required super.cost,
      required super.avatar,
      required super.category,
      required super.isInfinite,
      required super.isCommonReward,
      required super.receivers,
      required super.type,
      required super.createdBy,
      required super.parentId,
      required super.createdAt,
      super.available,
      super.description,
      required super.updatedAt});

  Map<String, dynamic> toMap([bool isUpdate = false]) {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'cost': cost,
      'avatar': avatar.toMap(),
      'category': (CategoryModel.fromEntity(category)).toMap(),
      'isInfinite': isInfinite,
      'available': available,
      'isCommonReward': isCommonReward,
      'receivers': receivers,
      'type': type.name,
      'createdBy': createdBy,
      'parentId': parentId,
      'createdAt': isUpdate ? createdAt : FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }

  static String get typeKey  {
    return "type";
  }

  static String get createdAtKey  {
    return "createdAt";
  }

  factory RewardModel.fromMap(Map<String, dynamic> map, String id) {
    return RewardModel(
      id: id,
      name: map['name'] as String,
      description:
          map['description'] != null ? map['description'] as String : null,
      cost: map['cost'] as int,
      avatar: FrameAvatarEntity.fromMap(map['avatar']),
      category: CategoryModel.fromMap(map['category']),
      isInfinite: map['isInfinite'] as bool,
      available: map['available'] != null ? map['available'] as int : null,
      isCommonReward: map['isCommonReward'] as bool,
      receivers: (map['receivers'] as List<String>),
      type: RewardType.fromString(map['type']),
      createdBy: map['createdBy'] as String,
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      updatedAt: (map['updatedAt'] as Timestamp).toDate(),
      parentId: map['parentId'] as String,
    );
  }

  factory RewardModel.fromEntity(RewardEntity entity) {
    return RewardModel(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      cost: entity.cost,
      avatar: entity.avatar,
      category: entity.category,
      isInfinite: entity.isInfinite,
      available: entity.available,
      isCommonReward: entity.isCommonReward,
      receivers: entity.receivers,
      type: entity.type,
      createdBy: entity.createdBy,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      parentId: entity.parentId,
    );
  }
}
