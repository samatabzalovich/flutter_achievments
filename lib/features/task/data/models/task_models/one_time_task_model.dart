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
      required super.commonTask,
      required super.withoutChecking,
      required super.isPhotoReportIncluded,
      required super.photoReport,
      required super.placedInSkipped,
      required super.createdAt});

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'state': state.name,
      'avatar': ( avatar as TaskModel).toMap(),
      'category': (category as CategoryModel).toMap(),
      'deadLine': deadLine.toIso8601String(),
      'startTime': startTime.toIso8601String(),
      'reward': reward,
      'parentId': parentId,
      'children': children,
      'commonTask': commonTask,
      'withoutChecking': withoutChecking,
      'isPhotoReportIncluded': isPhotoReportIncluded,
      'photoReport': photoReport?.toMap(),
      'placedInSkipped': placedInSkipped,
      'createdAt': createdAt,
    };
  }

  factory OneTimeTaskModel.fromMap(Map<String, dynamic> map) {
    return OneTimeTaskModel(
      id: map['id'],
      title: map['title'],
      state: map['state'],
      avatar: map['avatar'],
      category: map['category'],
      deadLine: DateTime.parse(map['deadLine']),
      startTime: DateTime.parse(map['startTime']),
      reward: map['reward'],
      parentId: map['parentId'],
      children: map['children'],
      commonTask: map['commonTask'],
      withoutChecking: map['withoutChecking'],
      isPhotoReportIncluded: map['isPhotoReportIncluded'],
      photoReport: map['photoReport'],
      placedInSkipped: map['placedInSkipped'],
      createdAt: map['createdAt'],
    );
  }
}
