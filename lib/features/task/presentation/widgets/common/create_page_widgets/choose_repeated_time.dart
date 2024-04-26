import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/common/widgets/custom_text.dart';
import 'package:flutter_achievments/core/constant/colors.dart';
import 'package:flutter_achievments/generated/locale_keys.g.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChooseRepeatedTime extends StatelessWidget {
  const ChooseRepeatedTime({super.key, required this.onRepeatedDaysSelected});
  final Function(List<int> repeatedDays) onRepeatedDaysSelected;
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
        RepeatedDaysCircles(
          onRepeatedDaysSelected: onRepeatedDaysSelected,
        ),
      ],
    );
  }
}

class RepeatedDaysCircles extends StatefulWidget {
  const RepeatedDaysCircles({
    super.key,
    this.onRepeatedDaysSelected,
    this.selectedDays,
  });

  final Function(List<int> repeatedDays)? onRepeatedDaysSelected;
  final List<int>? selectedDays;

  @override
  State<RepeatedDaysCircles> createState() => _RepeatedDaysCirclesState();
}

class _RepeatedDaysCirclesState extends State<RepeatedDaysCircles> {
  late List<int> selectedDays;
  late final double iconSize;
  @override
  void initState() {
    selectedDays = widget.selectedDays ?? [];
    iconSize = widget.selectedDays != null ? 32 : 40;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        if (widget.selectedDays != null)
          SizedBox(
            width: iconSize,
            height: iconSize,
            child: const DecoratedBox(
              decoration: BoxDecoration(
                color: lightBlue2,
                borderRadius: BorderRadius.all(
                  Radius.circular(40),
                ),
              ),
              child: Icon(
                Icons.calendar_month,
                color: Colors.white,
              ),
            ),
          ),
        _buildDayButton(1),
        _buildDayButton(2),
        _buildDayButton(3),
        _buildDayButton(4),
        _buildDayButton(5),
        _buildDayButton(6),
        _buildDayButton(7),
      ],
    );
  }

  Widget _buildDayButton(int day) {
    return GestureDetector(
      onTap: widget.onRepeatedDaysSelected != null
          ? () {
              setState(() {
                if (selectedDays.contains(day)) {
                  selectedDays.remove(day);
                } else {
                  selectedDays.add(day);
                }
                widget.onRepeatedDaysSelected!(selectedDays);
              });
            }
          : null,
      child: SizedBox(
        width: iconSize,
        height: iconSize,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: selectedDays.contains(day)
                ? greenButtonGradient2
                : Colors.transparent,
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
