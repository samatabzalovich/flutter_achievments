import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_achievments/core/common/avatar/frame_avatar.dart';
import 'package:flutter_achievments/core/enums/task_state.dart';
import 'package:flutter_achievments/features/task/data/models/shared/category_model.dart';
import 'package:flutter_achievments/features/task/data/models/task_models/task_model.dart';
import 'package:flutter_achievments/features/task/domain/entities/task_entities/one_time_task_entity.dart';

class OneTimeTaskModel extends OneTimeTaskEntity implements TaskModel {
  const OneTimeTaskModel(
      {required super.id,
      required super.title,
      required super.state,
      required super.avatar,
      required super.category,
      required super.deadLine,
      required super.startTime,
      required super.reward,
      required super.parentId,
      required super.children,
      required super.description,
      required super.commonTask,
      required super.withoutChecking,
      required super.isPhotoReportIncluded,
      required super.photoReport,
      required super.placedInSkipped,
      required super.createdAt});

  @override
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'state': state.name,
      'avatar': (avatar).toMap(),
      'category': (CategoryModel.fromEntity(category)).toMap(),
      'deadLine': Timestamp.fromDate(deadLine),
      'startTime': Timestamp.fromDate(startTime),
      'reward': reward,
      'parentId': parentId,
      'children': children,
      'commonTask': commonTask,
      'withoutChecking': withoutChecking,
      'isPhotoReportIncluded': isPhotoReportIncluded,
      'photoReport': photoReport?.toMap(),
      'placedInSkipped': placedInSkipped,
      'createdAt': FieldValue.serverTimestamp(),
      'description': description,
      'type': type.name,
    };
  }

  factory OneTimeTaskModel.fromMap(Map<String, dynamic> map) {
    return OneTimeTaskModel(
      id: map['id'],
      title: map['title'],
      state: TaskStateEnum.fromString(map['state']),
      avatar: FrameAvatarEntity.fromMap(map['avatar']),
      category: CategoryModel.fromMap(map['category']),
      deadLine: (map['deadLine'] as Timestamp).toDate(),
      startTime:  (map['startTime'] as Timestamp).toDate(),
      reward: map['reward'],
      parentId: map['parentId'],
      children:( map['children']as List).map((e) => e.toString()).toList(), 
      commonTask: map['commonTask'],
      withoutChecking: map['withoutChecking'],
      isPhotoReportIncluded: map['isPhotoReportIncluded'],
      photoReport: map['photoReport'],
      placedInSkipped: map['placedInSkipped'],
      createdAt: (map['createdAt']as Timestamp).toDate(),
      description: map['description'],
    );
  }

  static OneTimeTaskModel fromEntity(OneTimeTaskEntity entity) {
    return OneTimeTaskModel(
      id: entity.id,
      title: entity.title,
      state: entity.state,
      avatar: entity.avatar,
      category: entity.category,
      deadLine: entity.deadLine,
      startTime: entity.startTime,
      reward: entity.reward,
      parentId: entity.parentId,
      children: entity.children,
      commonTask: entity.commonTask,
      withoutChecking: entity.withoutChecking,
      isPhotoReportIncluded: entity.isPhotoReportIncluded,
      photoReport: entity.photoReport,
      placedInSkipped: entity.placedInSkipped,
      createdAt: entity.createdAt,
      description: entity.description,
    );
  }
}
