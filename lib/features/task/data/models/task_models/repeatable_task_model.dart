import 'package:flutter_achievments/features/task/data/models/shared/category_model.dart';
import 'package:flutter_achievments/features/task/data/models/task_models/task_avatar_model.dart';
import 'package:flutter_achievments/features/task/data/models/task_models/task_model.dart';
import 'package:flutter_achievments/features/task/domain/entities/task_entities/repeatable_task_entity.dart';

class RepeatableTaskModel extends RepeatableTaskEntity implements TaskModel{
  const RepeatableTaskModel({
    required super.id,
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
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'state': state.name,
      'avatar': (avatar as TaskAvatarModel).toMap(),
      'category': (category as CategoryModel).toMap(),
      'reward': reward,
      'parentId': parentId,
      'children': children,
      'commonTask': commonTask,
      'withoutChecking': withoutChecking,
      'isPhotoReportIncluded': isPhotoReportIncluded,
      'photoReport': photoReport.toMap(),
      'placedInSkipped': placedInSkipped,
      'repeatOnDays': repeatOnDays,
      'maximumReward': maximumReward,
      'isHidddenWhenMax': isHidddenWhenMax,
      'isMandatory': isMandatory,
      'createdAt': createdAt,
      'startTime': startTime,
    };
  }

  factory RepeatableTaskModel.fromMap(Map<String, dynamic> map) {
    return RepeatableTaskModel(
      id: map['id'],
      title: map['title'],
      state: map['state'],
      avatar: map['avatar'],
      category: map['category'],
      reward: map['reward'],
      parentId: map['parentId'],
      children: map['children'],
      commonTask: map['commonTask'],
      withoutChecking: map['withoutChecking'],
      isPhotoReportIncluded: map['isPhotoReportIncluded'],
      photoReport: map['photoReport'],
      placedInSkipped: map['placedInSkipped'],
      repeatOnDays: map['repeatOnDays'],
      maximumReward: map['maximumReward'],
      isHidddenWhenMax: map['isHidddenWhenMax'],
      isMandatory: map['isMandatory'],
      createdAt: map['createdAt'],
      startTime: map['startTime'],
    );
  }
}
