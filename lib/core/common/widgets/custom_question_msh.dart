import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/common/widgets/custom_text_no_tr.dart';
import 'package:flutter_achievments/core/constant/colors.dart';
import 'package:flutter_achievments/features/profile/presentation/widgets/common/show_modal_sheet.dart';
import 'package:flutter_achievments/generated/locale_keys.g.dart';

class CustomQuestionModalSheetRevealer extends StatelessWidget {
  const CustomQuestionModalSheetRevealer({
    super.key,
    required this.paragraphFirst,
    required this.paragraphSecond,
  });

  final String paragraphFirst;
  final String paragraphSecond;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
        child: CustomTextNoTr(
          '?',
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
      ),
    );
  }
}
