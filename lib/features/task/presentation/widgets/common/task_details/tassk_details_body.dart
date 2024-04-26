// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/common/widgets/blue_green_buttons.dart';
import 'package:flutter_achievments/core/common/widgets/custom_image_frame.dart';
import 'package:flutter_achievments/core/common/widgets/custom_text.dart';
import 'package:flutter_achievments/core/common/widgets/custom_text_no_tr.dart';
import 'package:flutter_achievments/core/common/widgets/text_with_desc.dart';
import 'package:flutter_achievments/core/constant/colors.dart';
import 'package:flutter_achievments/core/enums/task_state.dart';
import 'package:flutter_achievments/core/enums/task_type.dart';
import 'package:flutter_achievments/features/task/domain/entities/task_entities/one_time_task_entity.dart';
import 'package:flutter_achievments/features/task/domain/entities/task_entities/permanent_task_entity.dart';
import 'package:flutter_achievments/features/task/domain/entities/task_entities/repeatable_task_entity.dart';
import 'package:flutter_achievments/features/task/domain/entities/task_entities/task_entity.dart';
import 'package:flutter_achievments/features/task/presentation/widgets/common/create_page_widgets/choose_repeated_time.dart';
import 'package:flutter_achievments/features/task/presentation/widgets/common/task_details/custom_chat_button.dart';
import 'package:flutter_achievments/generated/locale_keys.g.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class TaskDetailsBody extends StatelessWidget {
  const TaskDetailsBody({
    super.key,
    required this.task,
  });
  final TaskEntity task;
  static const Map<TaskType, String> _svg = {
    TaskType.oneTime: 'assets/icons/Icononce.svg',
    TaskType.permanent: 'assets/icons/Iconrepeat.svg',
    TaskType.repeatable: 'assets/icons/Iconinfinity.svg',
  };

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                    child: Column(
                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                    CustomTextNoTr.darkBlueTitle(
                      task.title,
                    ),
                    _buildDescription(),
                    const SizedBox(
                      height: 24,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          _buildAvatarAndCategory(),
                          const SizedBox(
                            height: 24,
                          ),
                          _buildLeftScores(),
                          _buildRepeatOnDays(),
                          _buildTaskRequirements(),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                  ],
                )),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextAndGreenButtons(
                    textPressed: () {},
                    greenPressed: () {},
                    blueText: LocaleKeys.toCurrent,
                    greenText: LocaleKeys.ok),
              ),
            ],
          ),
          Positioned(
            bottom: 70,
            right: 20,
            child: CustomFloatingChatbutton(
              task: task,
            ),
          ),
        ],
      ),
    );
  }

  

  Widget _buildAvatarAndCategory() {
    return SizedBox(
      height: 144.h,
      child: Row(
        children: [
          Stack(
            children: [
              CustomImageFrame(
                  tileAvatar: task.avatar, size: 144.h, innerSize: 124.h),
              Align(
                  alignment: Alignment.topLeft,
                  child: SizedBox(
                    height: 36,
                    width: 36,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: lightBlue,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: SvgPicture.asset(
                          _svg[task.type]!,
                          width: 24,
                          height: 24,
                          colorFilter: const ColorFilter.mode(
                              Colors.white, BlendMode.srcIn),
                        ),
                      ),
                    ),
                  ))
            ],
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildTitleBlock(),
                _buildTaskStateBlock(),
                _buildRewardBlock(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildLeftScores() {
    if (task is PermanentTaskEntity || task is RepeatableTaskEntity) {
      int maximumPoints = 0;
      int taskCompletionNumber = 0;
      if (task is PermanentTaskEntity) {
        maximumPoints = (task as PermanentTaskEntity).maximumReward;
        taskCompletionNumber =
            (task as PermanentTaskEntity).taskCompletionNumber;
      } else if (task is RepeatableTaskEntity) {
        maximumPoints = (task as RepeatableTaskEntity).maximumReward;
        taskCompletionNumber =
            (task as RepeatableTaskEntity).taskCompletionNumber;
      }
      return (maximumPoints > 0)
          ? Builder(builder: (context) {
              final gainedPoints = taskCompletionNumber * task.reward;
              final leftScores = maximumPoints - gainedPoints;
              final pendingPoints = gainedPoints + task.reward;
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CustomText.darkBlueTitle(
                          LocaleKeys.leftScore,
                          fontSize: 16,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        SizedBox(
                          height: 40.h,
                          child: Row(
                            children: [
                              CustomTextNoTr.darkBlueTitle(
                                  leftScores.toString(),
                                  fontSize: 16),
                              const SizedBox(
                                width: 5,
                              ),
                              const CustomText.darkBlueTitle(LocaleKeys.outOf,
                                  fontSize: 16),
                              const SizedBox(
                                width: 5,
                              ),
                              CustomText.darkBlueTitle(maximumPoints.toString(),
                                  fontSize: 16),
                              SvgPicture.asset('assets/icons/gem.svg',
                                  width: 20.w, height: 25.h),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: DecoratedBox(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: LayoutBuilder(builder: (context, constraints) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                  color: lightBlue2,
                                ),
                                width: constraints.maxWidth *
                                    (gainedPoints / maximumPoints),
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                  color: greenButtonGradient2,
                                ),
                                width: constraints.maxWidth *
                                    (pendingPoints / maximumPoints),
                              ),
                            ],
                          );
                        }),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                ],
              );
            })
          : const SizedBox();
    } else {
      return const SizedBox();
    }
  }

  Widget _buildDescription() {
    return task.description != null
        ? Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              CustomTextNoTr.darkBlueTitle(
                task.description!,
                fontWeight: FontWeight.w600,
                fontSize: 14,
                textAlign: TextAlign.center,
              ),
            ],
          )
        : const SizedBox();
  }

  Widget _buildTitleBlock() {
    return SizedBox(
      height: 40.h,
      width: 230.w,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: lightBlue2,
          borderRadius: BorderRadius.circular(33.r),
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: CustomText(
              task.category.categoryName,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              textAlign: TextAlign.left,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTaskStateBlock() {
    late Color backGroundColor;

    switch (task.state) {
      case TaskStateEnum.active:
        backGroundColor = greyColor;
      case TaskStateEnum.refused:
      case TaskStateEnum.redo:
      case TaskStateEnum.rejected:
        backGroundColor = redColor;
      case TaskStateEnum.completed:
        backGroundColor = lightBlue;
      case TaskStateEnum.suggested:
        backGroundColor = greenButtonGradient2;
      case TaskStateEnum.pending:
        backGroundColor = scaffoldBackground;
    }

    return SizedBox(
      height: 40.h,
      width: 230.w,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: backGroundColor,
          borderRadius: BorderRadius.circular(33.r),
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: CustomText(
              task.state.name,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              textAlign: TextAlign.left,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRewardBlock() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        CustomTextNoTr.darkBlueTitle(
          '+${task.reward.toString()}',
          fontSize: 16,
        ),
        SvgPicture.asset('assets/icons/gem.svg', width: 20.w, height: 25.h),
        const SizedBox(
          width: 20,
        )
      ],
    );
  }

  Widget _buildRepeatOnDays() {
    return task is RepeatableTaskEntity
        ? Column(
            children: [
              const SizedBox(
                height: 12,
              ),
              RepeatedDaysCircles(
                selectedDays: (task as RepeatableTaskEntity).repeatOnDays,
              ),
              const SizedBox(
                height: 12,
              ),
            ],
          )
        : const SizedBox();
  }

  Widget _buildTaskRequirements() {
    DateTime? startTime;
    if (task is RepeatableTaskEntity) {
      startTime = (task as RepeatableTaskEntity).startTime;
    } else if (task is OneTimeTaskEntity) {
      startTime = (task as OneTimeTaskEntity).startTime;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        task is! PermanentTaskEntity
            ? _buildTaskReqBlock(
                LocaleKeys.doInChecking,
                Row(
                  children: [
                    _buildTimeTitleBlock(_getTimeOfTheDay(startTime!.hour))
                  ],
                ))
            : const SizedBox(),
        task is OneTimeTaskEntity
            ? _buildTaskReqBlock(
                LocaleKeys.deadLineTime,
                _buildTimeTitleBlock(
                  DateFormat(
                    'dd.MM.yyyy',
                  ).format((task as OneTimeTaskEntity).deadLine),
                ),
              )
            : const SizedBox(),
        if (task.isPhotoReportIncluded) _buildPhotoReport(),
      ],
    );
  }

  String _getTimeOfTheDay(int hour) {
    if (hour < 12) {
      return LocaleKeys.morning;
    } else if (hour < 18) {
      return LocaleKeys.afternoon;
    } else {
      return LocaleKeys.evening;
    }
  }

  Widget _buildPhotoReport() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TextWithDescription(
            title: LocaleKeys.photoReport,
            paragraphFirst: LocaleKeys.photoReportExplanation,
            paragraphSecond: ''),
        const SizedBox(
          height: 12,
        ),
        SizedBox(
          width: 215.w,
          height: 145.h,
          child: DecoratedBox(
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: lightBlue2, width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(10.r))),
              child: const Center(
                child: CustomText(
                  LocaleKeys.hereWillBePhotoReport,
                  fontSize: 14,
                  color: lightBlue2,
                  fontWeight: FontWeight.w600,
                ),
              )),
        ),
        const SizedBox(
          height: 24,
        ),
      ],
    );
  }

  Widget _buildTaskReqBlock(String title, Widget child) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText.darkBlueTitle(
                title,
                fontSize: 16,
              ),
              const SizedBox(
                width: 8,
              ),
              child,
            ],
          ),
          const Divider()
        ],
      ),
    );
  }

  Widget _buildTimeTitleBlock(String title) {
    return SizedBox(
      height: 40.w,
      child: DecoratedBox(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5.r))),
        child: Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomText.darkBlueTitle(
              title,
              fontSize: 14.sp,
              color: lightBlue2,
            ),
          ),
        ),
      ),
    );
  }
}
