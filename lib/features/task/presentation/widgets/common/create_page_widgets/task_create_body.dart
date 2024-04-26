import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/common/avatar/avatar.dart';
import 'package:flutter_achievments/core/common/avatar/frame_avatar.dart';
import 'package:flutter_achievments/core/common/widgets/animated_custom_button.dart';
import 'package:flutter_achievments/core/enums/task_state.dart';
import 'package:flutter_achievments/core/enums/task_type.dart';
import 'package:flutter_achievments/features/app/domain/shared_entities/child_entity.dart';
import 'package:flutter_achievments/features/app/domain/shared_entities/parent_entity.dart';
import 'package:flutter_achievments/features/app/presentation/provider/user_provider.dart';
import 'package:flutter_achievments/features/task/domain/entities/shared/category_entity.dart';
import 'package:flutter_achievments/features/task/domain/entities/task_entities/one_time_task_entity.dart';
import 'package:flutter_achievments/features/task/domain/entities/task_entities/permanent_task_entity.dart';
import 'package:flutter_achievments/features/task/domain/entities/task_entities/repeatable_task_entity.dart';
import 'package:flutter_achievments/features/task/domain/entities/task_entities/task_entity.dart';
import 'package:flutter_achievments/features/task/presentation/bloc/task_bloc/task_bloc.dart';
import 'package:flutter_achievments/features/task/presentation/widgets/common/create_page_widgets/additional_settings.dart';
import 'package:flutter_achievments/features/task/presentation/widgets/common/create_page_widgets/choose_category_body.dart';
import 'package:flutter_achievments/features/task/presentation/widgets/common/create_page_widgets/create_page_textfields.dart';
import 'package:flutter_achievments/features/task/presentation/widgets/common/create_page_widgets/task_performers.dart';
import 'package:flutter_achievments/features/task/presentation/widgets/common/create_page_widgets/task_preferences_body.dart';
import 'package:flutter_achievments/generated/locale_keys.g.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class TaskCreateBody extends StatefulWidget {
  const TaskCreateBody({super.key, required this.taskType});
  final TaskType taskType;
  @override
  State<TaskCreateBody> createState() => _TaskCreateBodyState();
}

class _TaskCreateBodyState extends State<TaskCreateBody>
    with SingleTickerProviderStateMixin {
  String taskName = '';
  String taskDescription = '';
  CategoryEntity? category;
  FrameAvatarEntity avatar = const FrameAvatarEntity(
      avatar: NoneAvatarEntity(), backgroundColor: Colors.blue);
  List<ChildEntity> performers = [];
  bool isCommonTask = false;
  DateTime? deadline;
  DateTime? startTime;
  bool dependsOnVolume = false;
  int points = 0;
  int maxPoints = 0;
  bool withoutChecking = false;
  bool photoReport = false;
  bool isHiddenWhenMax = false;
  bool placeInSkipped = false;
  bool mandatory = false;
  List<int> repeatOnDays = [];
  bool isDescIncluded = false;
  late ParentEntity currentUser;

  late AnimationController _buttonAnimationController;

  @override
  void initState() {
    currentUser = Provider.of<UserProvider>(context, listen: false).currentUser!
        as ParentEntity;
    _buttonAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    super.initState();
  }

  void _startButtonAnimation() {
    if (_checkAllFields()) {
      _buttonAnimationController.forward();
    } else {
      _buttonAnimationController.reverse();
    }
  }

  bool _checkAllFields() {
    List<int> shoudlBeEmpty = [];
    if (!(taskName.isNotEmpty &&
        category != null &&
        performers.isNotEmpty &&
        points != 0)) {
      shoudlBeEmpty.add(1);
    }
    if (dependsOnVolume) {
      if (points > maxPoints && maxPoints == 0) {
        shoudlBeEmpty.add(1);
      }
    }
    if (isDescIncluded) {
      if (taskDescription.isNotEmpty && taskDescription.length < 10) {
        shoudlBeEmpty.add(1);
      }
    }

    if (widget.taskType == TaskType.repeatable) {
      if (!repeatOnDays.isNotEmpty) {
        shoudlBeEmpty.add(1);
      }
    }
    return shoudlBeEmpty.isEmpty;
  }

  @override
  void dispose() {
    _buttonAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 40.h,
        ),
        child: Column(
          children: [
            CreatePageTextFields(
              onChanged:
                  (taskNameVal, taskDescriptionVal, isDescriptionProvided) {
                taskName = taskNameVal;
                taskDescription = taskDescriptionVal;
                isDescIncluded = isDescriptionProvided;
                _startButtonAnimation();
              },
            ),
            const SizedBox(
              height: 16,
            ),
            ChooseCategoryBody(
              onCategoryAndTaskAvatarSelected: (categoryVal, avatarVal) {
                category = categoryVal;
                avatar = avatarVal;
                _startButtonAnimation();
              },
            ),
            const SizedBox(
              height: 20,
            ),
            TaskPrefBody(
              taskType: widget.taskType,
              onTaskPrefSelected: (deadlineVal,
                  startTimeVal,
                  dependsOnVolumeVal,
                  pointsVal,
                  maxPoints,
                  isHiddenWhenMax,
                  days) {
                deadline = deadlineVal;
                startTime = startTimeVal;
                dependsOnVolume = dependsOnVolumeVal;
                points = pointsVal;
                this.isHiddenWhenMax = isHiddenWhenMax;
                this.maxPoints = maxPoints;
                repeatOnDays = days;
                _startButtonAnimation();
              },
            ),
            const SizedBox(
              height: 20,
            ),
            TaskPerformers(
              onPerformersSelected: (val, isCommonTaskVal) {
                performers = val;
                isCommonTask = isCommonTaskVal;
                _startButtonAnimation();
              },
            ),
            const SizedBox(
              height: 30,
            ),
            AdditionalSettings(
              type: widget.taskType,
              onAdditionalSettingsSelected: (withoutCheckingVal, photoReportVal,
                  placeInSkippedVal, mandatoryVal) {
                withoutChecking = withoutCheckingVal;
                photoReport = photoReportVal;
                placeInSkipped = placeInSkippedVal;
                mandatory = mandatoryVal;
                _startButtonAnimation();
              },
            ),
            const SizedBox(
              height: 45,
            ),
            AnimatedCustomButton(
              LocaleKeys.createTask,
              controller: _buttonAnimationController,
              width: MediaQuery.of(context).size.width * 0.78,
              onPressed: () {
                context.read<TaskCubit>().createTask(_createTask());
              },
            )
          ],
        ),
      ),
    );
  }

  TaskEntity _createTask() {
    switch (widget.taskType) {
      case TaskType.oneTime:
        return OneTimeTaskEntity(
            id: '',
            title: taskName,
            description: taskDescription,
            state: TaskStateEnum.active,
            avatar: avatar,
            category: category!,
            deadLine: deadline!,
            startTime: startTime!,
            reward: points,
            parentId: currentUser.id,
            children: performers.map((e) => e.id).toList(),
            commonTask: isCommonTask,
            withoutChecking: withoutChecking,
            isPhotoReportIncluded: photoReport,
            placedInSkipped: placeInSkipped,
            createdAt: DateTime.now());
      case TaskType.repeatable:
        return RepeatableTaskEntity(
            id: '',
            title: taskName,
            state: TaskStateEnum.active,
            taskCompletionNumber: 0,
            avatar: avatar,
            description: taskDescription,
            category: category!,
            startTime: startTime!,
            reward: points,
            parentId: currentUser.id,
            children: performers.map((e) => e.id).toList(),
            commonTask: isCommonTask,
            withoutChecking: withoutChecking,
            isPhotoReportIncluded: photoReport,
            placedInSkipped: placeInSkipped,
            repeatOnDays: repeatOnDays,
            maximumReward: maxPoints,
            isHidddenWhenMax: isHiddenWhenMax,
            isMandatory: mandatory,
            createdAt: DateTime.now());
      case TaskType.permanent:
        return PermanentTaskEntity(
            id: '',
            title: taskName,
            state: TaskStateEnum.active,
            avatar: avatar,
            category: category!,
            description: taskDescription,
            reward: points,
            parentId: currentUser.id,
            children: performers.map((e) => e.id).toList(),
            commonTask: isCommonTask,
            withoutChecking: withoutChecking,
            isPhotoReportIncluded: photoReport,
            taskCompletionNumber: 0,
            maximumReward: maxPoints,
            isHidddenWhenMax: isHiddenWhenMax,
            isMandatory: mandatory,
            createdAt: DateTime.now());
    }
  }
}
