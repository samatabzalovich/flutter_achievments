import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/common/avatar/avatar.dart';
import 'package:flutter_achievments/core/common/widgets/animated_custom_button.dart';
import 'package:flutter_achievments/core/enums/task_type.dart';
import 'package:flutter_achievments/features/app/domain/shared_entities/child_entity.dart';
import 'package:flutter_achievments/features/task/domain/entities/shared/category_entity.dart';
import 'package:flutter_achievments/features/task/presentation/widgets/common/create_page_widgets/additional_settings.dart';
import 'package:flutter_achievments/features/task/presentation/widgets/common/create_page_widgets/choose_category_body.dart';
import 'package:flutter_achievments/features/task/presentation/widgets/common/create_page_widgets/create_page_textfields.dart';
import 'package:flutter_achievments/features/task/presentation/widgets/common/create_page_widgets/task_performers.dart';
import 'package:flutter_achievments/features/task/presentation/widgets/common/create_page_widgets/task_preferences_body.dart';
import 'package:flutter_achievments/generated/locale_keys.g.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  AvatarEntity? avatar;
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
  List<int> days = [];

  late AnimationController _buttonAnimationController;

  @override
  void initState() {
    _buttonAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    super.initState();
  }

  void _checkAllFields() {
    if (taskName.isNotEmpty &&
        category != null &&
        performers.isNotEmpty &&
        points != 0) {
      _buttonAnimationController.forward();
    } else {
      _buttonAnimationController.reverse();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _buttonAnimationController.dispose();
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
              onChanged: (taskNameVal, taskDescriptionVal) {
                taskName = taskNameVal;
                taskDescription = taskDescriptionVal;
                _checkAllFields();
              },
            ),
            const SizedBox(
              height: 16,
            ),
            ChooseCategoryBody(
              onCategoryAndTaskAvatarSelected: (categoryVal, avatarVal) {
                category = categoryVal;
                avatar = avatarVal;
                _checkAllFields();
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
                this.days = days;
                _checkAllFields();
              },
            ),
            const SizedBox(
              height: 20,
            ),
            TaskPerformers(
              onPerformersSelected: (val, isCommonTaskVal) {
                performers = val;
                isCommonTask = isCommonTaskVal;
                _checkAllFields();
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
                _checkAllFields();
              },
            ),
            const SizedBox(
              height: 45,
            ),
            AnimatedCustomButton(
              LocaleKeys.createTask,
              controller: _buttonAnimationController,
              width: MediaQuery.of(context).size.width * 0.78,
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
