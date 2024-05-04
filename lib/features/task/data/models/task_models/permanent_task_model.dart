import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_achievments/core/common/avatar/frame_avatar.dart';
import 'package:flutter_achievments/core/enums/task_state.dart';
import 'package:flutter_achievments/features/task/data/models/shared/category_model.dart';
import 'package:flutter_achievments/features/task/data/models/task_models/task_avatar_model.dart';
import 'package:flutter_achievments/features/task/data/models/task_models/task_model.dart';
import 'package:flutter_achievments/features/task/domain/entities/task_entities/permanent_task_entity.dart';

class PermanentTaskModel extends PermanentTaskEntity implements TaskModel {
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
      required super.maximumReward,
      required super.isHidddenWhenMax,
      required super.isMandatory,
      required super.description,
      required super.createdAt,
      required super.taskCompletionNumber});

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'state': state.name,
      'avatar': (avatar ).toMap(),
      'category': ( CategoryModel.fromEntity(category)).toMap(),
      'reward': reward,
      'parentId': parentId,
      'children': children,
      'commonTask': commonTask,
      'withoutChecking': withoutChecking,
      'isPhotoReportIncluded': isPhotoReportIncluded,
      'photoReport': photoReport?.toMap(),
      'maximumReward': maximumReward,
      'isHidddenWhenMax': isHidddenWhenMax,
      'isMandatory': isMandatory,
      'createdAt': FieldValue.serverTimestamp(),
      'taskCompletionNumber': taskCompletionNumber,
      'description': description,
      'type': type.name,
      'startTime': null,
      'repeatOnDays': null,
      
    };
  }

  factory PermanentTaskModel.fromMap(Map<String, dynamic> map) {
    return PermanentTaskModel(
      id: map['id'],
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
      maximumReward: map['maximumReward'],
      isHidddenWhenMax: map['isHidddenWhenMax'],
      isMandatory: map['isMandatory'],
      createdAt: (map['createdAt']as Timestamp).toDate(),
      taskCompletionNumber: map['taskCompletionNumber'],
      description: map['description'],
    );
  }

  static PermanentTaskModel fromEntity(PermanentTaskEntity entity) {
    return PermanentTaskModel(
      id: entity.id,
      title: entity.title,
      state: entity.state,
      avatar: entity.avatar,
      category: entity.category ,
      reward: entity.reward,
      parentId: entity.parentId,
      children: entity.children,
      commonTask: entity.commonTask,
      withoutChecking: entity.withoutChecking,
      isPhotoReportIncluded: entity.isPhotoReportIncluded,
      photoReport: entity.photoReport,
      maximumReward: entity.maximumReward,
      isHidddenWhenMax: entity.isHidddenWhenMax,
      isMandatory: entity.isMandatory,
      createdAt: entity.createdAt,
      taskCompletionNumber: entity.taskCompletionNumber,
      description: entity.description,
    );
  }
}
