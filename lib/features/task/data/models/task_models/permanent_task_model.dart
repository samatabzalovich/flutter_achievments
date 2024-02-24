import 'package:flutter_achievments/features/task/data/models/shared/category_model.dart';
import 'package:flutter_achievments/features/task/data/models/task_models/task_avatar_model.dart';
import 'package:flutter_achievments/features/task/data/models/task_models/task_model.dart';
import 'package:flutter_achievments/features/task/domain/entities/task_entities/permanent_task_entity.dart';

class PermanentTaskModel extends PermanentTaskEntity implements TaskModel{
  const PermanentTaskModel(
      {required super.id,
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
      required super.repeatOnDays,
      required super.maximumReward,
      required super.isHidddenWhenMax,
      required super.isMandatory,
      required super.createdAt,});

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'state': state.name,
      'avatar': ( avatar as TaskAvatarModel).toMap(),
      'category': (category as CategoryModel).toMap(),
      'reward': reward,
      'parentId': parentId,
      'children': children,
      'commonTask': commonTask,
      'withoutChecking': withoutChecking,
      'isPhotoReportIncluded': isPhotoReportIncluded,
      'photoReport': photoReport.toMap(),
      'repeatOnDays': repeatOnDays,
      'maximumReward': maximumReward,
      'isHidddenWhenMax': isHidddenWhenMax,
      'isMandatory': isMandatory,
      'createdAt': createdAt,
    };
  }

  factory PermanentTaskModel.fromMap(Map<String, dynamic> map) {
    return PermanentTaskModel(
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
      repeatOnDays: map['repeatOnDays'],
      maximumReward: map['maximumReward'],
      isHidddenWhenMax: map['isHidddenWhenMax'],
      isMandatory: map['isMandatory'],
      createdAt: map['createdAt'],
    );
  }
}