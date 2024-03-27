import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/common/dialogs/show_error_dialog.dart';
import 'package:flutter_achievments/core/common/widgets/custom_text.dart';
import 'package:flutter_achievments/core/common/widgets/custom_text_no_tr.dart';
import 'package:flutter_achievments/core/constant/colors.dart';
import 'package:flutter_achievments/core/enums/task_type.dart';
import 'package:flutter_achievments/features/profile/presentation/widgets/common/custom_switch_description.dart';
import 'package:flutter_achievments/features/profile/presentation/widgets/common/show_modal_sheet.dart';
import 'package:flutter_achievments/features/task/presentation/widgets/common/create_page_widgets/choose_repeated_time.dart';
import 'package:flutter_achievments/generated/locale_keys.g.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class TaskPrefBody extends StatefulWidget {
  const TaskPrefBody(
      {super.key, required this.onTaskPrefSelected, required this.taskType});
  final Function(
      DateTime deadline,
      DateTime startTime,
      bool dependsOnVolume,
      int points,
      int maxPoints,
      bool isHiddenWhenMax,
      List<int> days) onTaskPrefSelected;
  final TaskType taskType;
  @override
  State<TaskPrefBody> createState() => _TaskPrefBodyState();
}

class _TaskPrefBodyState extends State<TaskPrefBody> {
  DateTime deadline = DateTime.now();
  DateTime startTime = DateTime.now();
  bool dependsOnVolume = false;
  int points = 0;
  int maxPoints = 0;
  bool isHiddenWhenMax = false;
  bool onLongPress = false;
  bool showWarningMessage = false;
  List<int> days = [];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomText.darkBlueTitle(LocaleKeys.taskPreferenses),
        if (widget.taskType == TaskType.repeatable)
          ChooseRepeatedTime(onRepeatedDaysSelected: (days) {
            widget.onTaskPrefSelected(deadline, startTime, dependsOnVolume,
                points, maxPoints, isHiddenWhenMax, days);
          }),
        if (widget.taskType == TaskType.oneTime)
          Column(
            children: [
              const SizedBox(
                height: 25,
              ),
              _buildDatePicker(
                date: startTime,
                onDateSelected: (date) {
                  setState(() {
                    startTime = date;
                  });
                  widget.onTaskPrefSelected(
                      deadline,
                      startTime,
                      dependsOnVolume,
                      points,
                      maxPoints,
                      isHiddenWhenMax,
                      days);
                },
                isTimestamp: false,
                title: LocaleKeys.startDate,
                paragraphFirst: LocaleKeys.startDateDescription,
                paragraphSecond: LocaleKeys.startDateDescription2,
              ),
            ],
          ),
        if (widget.taskType != TaskType.permanent)
          Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              _buildDatePicker(
                date: startTime,
                onDateSelected: (date) {
                  setState(() {
                    startTime = DateTime(startTime.year, startTime.month,
                        startTime.day, date.hour, date.minute);
                  });
                  widget.onTaskPrefSelected(
                      deadline,
                      startTime,
                      dependsOnVolume,
                      points,
                      maxPoints,
                      isHiddenWhenMax,
                      days);
                },
                isTimestamp: true,
                title: LocaleKeys.startTime,
                paragraphFirst: LocaleKeys.startTimeDescription,
                paragraphSecond: LocaleKeys.startTimeDescription2,
              ),
            ],
          ),
        if (widget.taskType == TaskType.oneTime)
          Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              _buildDatePicker(
                date: deadline,
                onDateSelected: (date) {
                  setState(() {
                    deadline = date;
                  });
                  widget.onTaskPrefSelected(
                    deadline,
                    startTime,
                    dependsOnVolume,
                    points,
                    maxPoints,
                    isHiddenWhenMax,
                    days,
                  );
                },
                isTimestamp: false,
                title: LocaleKeys.deadLineTime,
                paragraphFirst: LocaleKeys.deadLineTimeDescription,
                paragraphSecond: LocaleKeys.deadLineTimeDescription2,
              ),
            ],
          ),
        if (widget.taskType != TaskType.oneTime) _buildDependsOnVolume(),
        Row(
          children: [
            CustomText.darkBlueTitle(
              dependsOnVolume ? LocaleKeys.executionsPoints : LocaleKeys.reward,
              fontSize: 16,
            ),
            GestureDetector(
              onTap: () {
                showCustomSheet(context,
                    paragraph1: dependsOnVolume
                        ? LocaleKeys.dependsOnVolumeDescription2
                        : LocaleKeys.rewardDescription,
                    paragraph2: '');
              },
              child: Container(
                margin: const EdgeInsets.only(left: 20),
                width: 22,
                height: 22,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: darkBlue,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: CustomText(
                  LocaleKeys.questionMark,
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        _buildRewardField(),
      ],
    );
  }

  Widget _buildDatePicker(
      {required Function(DateTime date) onDateSelected,
      required bool isTimestamp,
      required String title,
      required String paragraphFirst,
      required String paragraphSecond,
      required DateTime date}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CustomText.darkBlueTitle(
              title,
              fontSize: 16,
            ),
            GestureDetector(
              onTap: () {
                showCustomSheet(context,
                    paragraph1: paragraphFirst, paragraph2: paragraphSecond);
              },
              child: Container(
                margin: const EdgeInsets.only(left: 20),
                width: 22,
                height: 22,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: darkBlue,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: CustomText(
                  LocaleKeys.questionMark,
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
              ),
            ),
          ],
        ),
        GestureDetector(
          onTap: () async {
            if (isTimestamp) {
              await _showTimePicker(onDateSelected, date);
            } else {
              final selectedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime(2025),
              );
              if (selectedDate != null) {
                onDateSelected(DateTime(selectedDate.year, selectedDate.month,
                    selectedDate.day, date.hour, date.minute));
              }
            }
          },
          child: SizedBox(
            height: 44.h,
            width: 120.w,
            child: DecoratedBox(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: Colors.white),
              child: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  CustomTextNoTr(
                    isTimestamp
                        ? DateFormat('HH:mm').format(date)
                        : DateFormat('dd.MM').format(date),
                    color: lightBlue2,
                    fontSize: 16,
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.keyboard_arrow_down,
                    color: lightBlue2,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildRewardField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildRewardDefine(
          (int points) {
            setState(() {
              this.points += points;
              showWarningMessage = true;
            });
            widget.onTaskPrefSelected(deadline, startTime, dependsOnVolume,
                this.points, maxPoints, isHiddenWhenMax, days);
          },
          points,
        ),
        const SizedBox(
          height: 10,
        ),
        if (points == 0 && showWarningMessage)
          const CustomText(
            LocaleKeys.definePoints,
            color: redColor,
            fontSize: 14,
          ),
        _buildMaxPointField(),
      ],
    );
  }

  Widget _buildRewardDefine(
      Function(int points) onPointsSelected, int initalPoints) {
    return SizedBox(
      height: 64.h,
      child: Stack(
        children: [
          SizedBox.expand(
              child: Container(
            padding: EdgeInsets.only(right: 10.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r), color: lightBlue2),
            child: SvgPicture.asset(
              'assets/icons/gem.svg',
              width: 30.h,
              height: 30.h,
              alignment: Alignment.centerRight,
              fit: BoxFit.scaleDown,
            ),
          )),
          Align(
              alignment: Alignment.center,
              child: SizedBox.expand(
                child: Padding(
                  padding: EdgeInsets.only(right: 48.w),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.r),
                        color: Colors.white),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            color: lightBlue2,
                            onPressed: () {
                              if (initalPoints >= 10) {
                                onPointsSelected(-10);
                              }
                            },
                            icon: const Icon(Icons.keyboard_double_arrow_left)),
                        _buildCustomDivider(24.h),
                        IconButton(
                            color: lightBlue2,
                            onPressed: () {
                              if (initalPoints > 0) {
                                onPointsSelected(-1);
                              }
                            },
                            icon: const Icon(Icons.keyboard_arrow_left)),
                        _buildCustomDivider(8.h),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: CustomTextNoTr.darkBlueTitle(
                              initalPoints.toString()),
                        ),
                        _buildCustomDivider(8.h),
                        IconButton(
                            color: lightBlue2,
                            onPressed: () {
                              onPointsSelected(1);
                            },
                            icon: const Icon(Icons.keyboard_arrow_right)),
                        _buildCustomDivider(24.h),
                        IconButton(
                            color: lightBlue2,
                            onPressed: () {
                              onPointsSelected(10);
                            },
                            icon:
                                const Icon(Icons.keyboard_double_arrow_right)),
                      ],
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildMaxPointField() {
    if (dependsOnVolume) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 25,
          ),
          const CustomText.darkBlueTitle(
            LocaleKeys.maximumPoints,
            fontSize: 16,
          ),
          const SizedBox(
            height: 20,
          ),
          _buildRewardDefine((int pointsVal) {
            setState(() {
              maxPoints += pointsVal;
              showWarningMessage = true;
            });
            widget.onTaskPrefSelected(deadline, startTime, dependsOnVolume,
                points, maxPoints, isHiddenWhenMax, days);
          }, maxPoints),
          const SizedBox(
            height: 10,
          ),
          if ((maxPoints == 0 && showWarningMessage) ||
              maxPoints < points && showWarningMessage)
            CustomText(
              (maxPoints < points)
                  ? LocaleKeys.maxPointShouldBeMoreThanRewardPoint
                  : LocaleKeys.defineMaxPointReward,
              color: redColor,
              fontSize: 14,
              textAlign: TextAlign.start,
            ),
          CustomSwitchDescription(
              onChanged: (val) {
                setState(() {
                  isHiddenWhenMax = val;
                });
                widget.onTaskPrefSelected(deadline, startTime, dependsOnVolume,
                    points, maxPoints, isHiddenWhenMax, days);
              },
              paragraphFirst: LocaleKeys.hideWhenMaxDescription,
              paragraphSecond: '',
              description: LocaleKeys.hideWhenMax)
        ],
      );
    } else {
      return const SizedBox();
    }
  }

  Widget _buildCustomDivider(double verticalPadding) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: verticalPadding),
      child: const SizedBox(
        width: 1,
        height: double.infinity,
        child: DecoratedBox(
          decoration: BoxDecoration(color: greyColor),
        ),
      ),
    );
  }

  Widget _buildDependsOnVolume() {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        CustomSwitchDescription(
            onChanged: (value) {
              setState(() {
                dependsOnVolume = value;
              });
              widget.onTaskPrefSelected(deadline, startTime, dependsOnVolume,
                  points, maxPoints, isHiddenWhenMax, days);
            },
            paragraphFirst: LocaleKeys.dependsOnVolumeDescription,
            paragraphSecond: LocaleKeys.dependsOnVolumeDescription2,
            description: LocaleKeys.dependsOnVolume),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Future<void> _showTimePicker(
      Function(DateTime selectedDate) onDateSelected, DateTime date) async {
    //pick time
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (picked != null) {
      final selected =
          DateTime(date.year, date.month, date.day, picked.hour, picked.minute);
      if (selected.isAfter(DateTime.now())) {
        onDateSelected(selected);
      } else {
        if (mounted) {
          await showErrorDialog(
              dialogTitle: LocaleKeys.error.tr(),
              dialogText: LocaleKeys.errorTimeShouldBeAfterCurrentTime.tr(),
              context: context);
        }
      }
    }
  }
}
