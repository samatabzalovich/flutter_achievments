import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/common/widgets/custom_text_no_tr.dart';
import 'package:flutter_achievments/features/task/presentation/provider/selected_date_provider.dart';
import 'package:flutter_achievments/features/task/presentation/widgets/common/custom_date_picker.dart';
import 'package:flutter_achievments/generated/locale_keys.g.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class DatePickerWidget extends StatefulWidget {
  const DatePickerWidget(
      {super.key,
      required this.draggableScrollableController,
      required this.minChildSize,
      required this.maxChildSize});
  final DraggableScrollableController draggableScrollableController;
  final double minChildSize;
  final double maxChildSize;
  @override
  State<DatePickerWidget> createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  double _opacityDatePicker = 1.0;
  double progress = 1;
  @override
  void initState() {
    super.initState();
    widget.draggableScrollableController.addListener(() {
      double size = widget.draggableScrollableController.size;
      if (size <= widget.minChildSize) {
        setState(() {
          _opacityDatePicker = 1.0;
        });
      } else if (size >= widget.maxChildSize) {
        setState(() {
          _opacityDatePicker = 0.0;
        });
      } else {
        // Calculate the opacity based on the size
        progress = (size - widget.maxChildSize) /
            (widget.minChildSize - widget.maxChildSize);
        setState(() {
          _opacityDatePicker = progress;
        });
      }
    });
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 17.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10 * _opacityDatePicker,
          ),
          AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: _opacityDatePicker,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: _opacityDatePicker == 0 ? 0 : 48.h,
              child: CustomDatePicker(
                onDateChanged: (DateTime date) {
                  setState(() {
                    selectedDate = date;
                  });
                  Provider.of<SelectedDateProvider>(context, listen: false)
                      .setSelectedDate(date);
                },
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          CustomTextNoTr.darkBlueTitle(
            _getDateString,
            fontSize: 16,
          ),
        ],
      ),
    );
  }

  String get _getDateString {
    if (selectedDate.day == DateTime.now().day) {
      return LocaleKeys.tasksForToday.tr();
    } else if (selectedDate.day ==
        DateTime.now().subtract(const Duration(days: 1)).day) {
      return LocaleKeys.tasksForYesterday.tr();
    } else if (selectedDate.day ==
        DateTime.now().add(const Duration(days: 1)).day) {
      return LocaleKeys.tasksForTomorrow.tr();
    } else {
      return '${LocaleKeys.tasksFor.tr()} ${selectedDate.day}.${DateFormat('MM').format(selectedDate)}';
    }
  }
}
