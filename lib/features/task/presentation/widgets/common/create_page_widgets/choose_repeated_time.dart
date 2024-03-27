import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/common/widgets/custom_text.dart';
import 'package:flutter_achievments/core/constant/colors.dart';
import 'package:flutter_achievments/generated/locale_keys.g.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChooseRepeatedTime extends StatefulWidget {
  const ChooseRepeatedTime({super.key, required this.onRepeatedDaysSelected});
  final Function(List<int> repeatedDays) onRepeatedDaysSelected;
  @override
  State<ChooseRepeatedTime> createState() => _ChooseRepeatedTimeState();
}

class _ChooseRepeatedTimeState extends State<ChooseRepeatedTime> {
  List<int> selectedDays = [];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        const CustomText.darkBlueTitle(
          LocaleKeys.byDayOfWeek,
          fontSize: 16,
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildDayButton(1),
            _buildDayButton(2),
            _buildDayButton(3),
            _buildDayButton(4),
            _buildDayButton(5),
            _buildDayButton(6),
            _buildDayButton(7),
          ],
        ),
      ],
    );
  }

  Widget _buildDayButton(int day) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (selectedDays.contains(day)) {
            selectedDays.remove(day);
          } else {
            selectedDays.add(day);
          }
          widget.onRepeatedDaysSelected(selectedDays);
        });
      },
      child: SizedBox(
        width: 40,
        height: 40,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: selectedDays.contains(day) ? greenButtonGradient2 : Colors.transparent,
            borderRadius: BorderRadius.circular(40.r),
          ),
          child: Center(
            child: CustomText(
              'week${day}day',
              color: selectedDays.contains(day) ? Colors.white : lightBlue2,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
