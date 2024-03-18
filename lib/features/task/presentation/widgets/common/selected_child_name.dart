import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/common/widgets/custom_text.dart';
import 'package:flutter_achievments/core/common/widgets/custom_text_no_tr.dart';
import 'package:flutter_achievments/features/app/presentation/provider/selected_user_provider.dart';
import 'package:flutter_achievments/generated/locale_keys.g.dart';
import 'package:provider/provider.dart';

class SelectedChildName extends StatelessWidget {
  const SelectedChildName({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedChild =
        Provider.of<SelectedUserProvider>(context, listen: true).selectedUser;
    final selectedDate = DateTime.now();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        selectedChild != null
            ? CustomTextNoTr(selectedChild.name!)
            : const CustomText(LocaleKeys.allTasks),
        const SizedBox(
          height: 3,
        ),
        CustomTextNoTr(
          '${selectedDate.day} ${DateFormat('MMMM', context.locale.languageCode).format(selectedDate)}',
          fontSize: 12,
        )
      ],
    );
  }
}
