import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/common/widgets/custom_text_no_tr.dart';
import 'package:flutter_achievments/features/app/domain/shared_entities/child_entity.dart';
import 'package:flutter_achievments/features/app/domain/shared_entities/parent_entity.dart';
import 'package:flutter_achievments/features/app/presentation/provider/selected_user_provider.dart';
import 'package:flutter_achievments/features/app/presentation/provider/user_provider.dart';
import 'package:flutter_achievments/generated/locale_keys.g.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class CustomDatePicker extends StatefulWidget {
  const CustomDatePicker({super.key, required this.onDateChanged});
  final Function(DateTime) onDateChanged;
  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    final DateTime firstDate = _getFirstDate(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: firstDate.day != selectedDate.day ?() {
              setState(() {
                selectedDate = selectedDate.subtract(const Duration(days: 1));
              });
              widget.onDateChanged(selectedDate);
            } : null,
            child: const Icon(Icons.arrow_back_ios),
          ),
          TextButton(
            onPressed: () async {
              final DateTime? picked = await showDatePicker(
                context: context,
                locale: context.locale,
                initialDate: selectedDate,
                firstDate: firstDate,
                lastDate: DateTime(2101),
              );
              if (picked != null && picked != selectedDate) {
                setState(() {
                  selectedDate = picked;
                });
                widget.onDateChanged(selectedDate);
              }
            },
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/calendar.svg',
                  width: 25.w,
                  height: 25.w,
                ),
                const SizedBox(
                  width: 8,
                ),
                CustomTextNoTr.darkBlueTitle(
                  _getDateString,
                  fontSize: 16,
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                selectedDate = selectedDate.add(const Duration(days: 1));
              });

              widget.onDateChanged(selectedDate);
            },
            child: const Icon(Icons.arrow_forward_ios),
          ),
        ],
      ),
    );
  }

  String get _getDateString {
    if (selectedDate.day == DateTime.now().day) {
      return '${LocaleKeys.today.tr()} ${selectedDate.day}.${DateFormat('MM').format(selectedDate)}';
    } else if (selectedDate.day ==
        DateTime.now().subtract(const Duration(days: 1)).day) {
      return '${LocaleKeys.yesterday.tr()} ${selectedDate.day}.${DateFormat('MM').format(selectedDate)}';
    } else if (selectedDate.day ==
        DateTime.now().add(const Duration(days: 1)).day) {
      return '${LocaleKeys.tomorrow.tr()} ${selectedDate.day}.${DateFormat('MM').format(selectedDate)}';
    } else {
      return '${selectedDate.day}.${DateFormat('MM').format(selectedDate)}.${selectedDate.year}';
    }
  }

  DateTime _getFirstDate(BuildContext context) {
    final selectedChild =
        Provider.of<SelectedUserProvider>(context).selectedUser as ChildEntity?;
    if (selectedChild != null) {
      return selectedChild.createdAt;
    }
    final children = (Provider.of<UserProvider>(context).currentUser! as ParentEntity).children;
    DateTime firstDate = DateTime.now();
    if (children != null && children.isNotEmpty) {
      for (final child in  children) {
      if (child.createdAt.isBefore(firstDate)) {
        firstDate = child.createdAt;
      }
    }
    }
    return firstDate;
  }
}
