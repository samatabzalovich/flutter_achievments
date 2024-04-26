import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/common/widgets/custom_question_msh.dart';
import 'package:flutter_achievments/core/common/widgets/custom_text.dart';

class TextWithDescription extends StatelessWidget {
  const TextWithDescription(
      {super.key,
      required this.title,
      required this.paragraphFirst,
      required this.paragraphSecond});
  final String title;
  final String paragraphFirst;
  final String paragraphSecond;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText.darkBlueTitle(title,
            fontSize: 16, textAlign: TextAlign.left),
        Row(
          children: [
            CustomQuestionModalSheetRevealer(
                paragraphFirst: paragraphFirst,
                paragraphSecond: paragraphSecond),
            const SizedBox(
              width: 15,
            )
          ],
        )
      ],
    );
  }
}
