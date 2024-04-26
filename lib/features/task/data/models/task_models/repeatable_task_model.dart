import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_achievments/core/common/avatar/frame_avatar.dart';
import 'package:flutter_achievments/core/enums/task_state.dart';
import 'package:flutter_achievments/features/task/data/models/shared/category_model.dart';
import 'package:flutter_achievments/features/task/data/models/task_models/task_model.dart';
import 'package:flutter_achievments/features/task/domain/entities/task_entities/repeatable_task_entity.dart';

class RepeatableTaskModel extends RepeatableTaskEntity implements TaskModel {
  const RepeatableTaskModel({
    required super.id,
    required super.taskCompletionNumber,
    required super.title,
    required super.state,
    required super.avatar,
    required super.category,
    required super.reward,
    required super.parentId,
    required super.children,
    required super.commonTask,
    required super.withoutChecking,
    required super.isPhotoReportIncluded,
    required super.photoReport,
    required super.placedInSkipped,
    required super.repeatOnDays,
    required super.maximumReward,
    required super.isHidddenWhenMax,
    required super.isMandatory,
    required super.createdAt,
    required super.startTime,
    required super.description,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'state': state.name,
      'avatar': (avatar).toMap(),
      'category': (CategoryModel.fromEntity(category)).toMap(),
      'reward': reward,
      'parentId': parentId,
      'children': children,
      'commonTask': commonTask,
      'withoutChecking': withoutChecking,
      'isPhotoReportIncluded': isPhotoReportIncluded,
      'photoReport': photoReport?.toMap(),
      'placedInSkipped': placedInSkipped,
      'repeatOnDays': repeatOnDays,
      'maximumReward': maximumReward,
      'isHidddenWhenMax': isHidddenWhenMax,
      'description': description,
      'isMandatory': isMandatory,
      'createdAt': FieldValue.serverTimestamp(),
      'startTime': DateTime(2015, 2, 3, startTime.hour, startTime.minute),
      'taskCompletionNumber': taskCompletionNumber,
      'type': type.name,
    };
  }

  factory RepeatableTaskModel.fromMap(Map<String, dynamic> map) {
    return RepeatableTaskModel(
      id: map['id'],
      taskCompletionNumber: map['taskCompletionNumber'],
      title: map['title'],
      state: TaskStateEnum.fromString(map['state']),
      avatar: FrameAvatarEntity.fromMap(map['avatar']),
      category: CategoryModel.fromMap(map['category']),
      reward: map['reward'],
      parentId: map['parentId'],
      children:( map['children']as List).map((e) => e.toString()).toList(), 
      commonTask: map['commonTask'],
      withoutChecking: map['withoutChecking'],
      isPhotoReportIncluded: map['isPhotoReportIncluded'],
      photoReport: map['photoReport'],
      placedInSkipped: map['placedInSkipped'],
      repeatOnDays: (map['repeatOnDays'] as List<dynamic>).map((e) => e as int).toList(),
      maximumReward: map['maximumReward'],
      isHidddenWhenMax: map['isHidddenWhenMax'],
      isMandatory: map['isMandatory'],
      createdAt: (map['createdAt']as Timestamp).toDate(),
      startTime: (map['startTime'] as Timestamp).toDate(),
      description: map['description'],
    );
  }

  static RepeatableTaskModel fromEntity(RepeatableTaskEntity entity) {
    return RepeatableTaskModel(
      id: entity.id,
      taskCompletionNumber: entity.taskCompletionNumber,
      title: entity.title,
      state: entity.state,
      avatar: entity.avatar,
      category: entity.category,
      reward: entity.reward,
      parentId: entity.parentId,
      children: entity.children,
      commonTask: entity.commonTask,
      withoutChecking: entity.withoutChecking,
      isPhotoReportIncluded: entity.isPhotoReportIncluded,
      photoReport: entity.photoReport,
      placedInSkipped: entity.placedInSkipped,
      repeatOnDays: entity.repeatOnDays,
      maximumReward: entity.maximumReward,
      isHidddenWhenMax: entity.isHidddenWhenMax,
      isMandatory: entity.isMandatory,
      createdAt: entity.createdAt,
      startTime: entity.startTime,
      description: entity.description,
    );
  }
}
