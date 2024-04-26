import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/common/widgets/custom_question_msh.dart';
import 'package:flutter_achievments/core/common/widgets/custom_text.dart';
import 'package:flutter_achievments/core/constant/colors.dart';

class CustomSwitchDescription extends StatefulWidget {
  const CustomSwitchDescription(
      {super.key,
      required this.onChanged,
      required this.paragraphFirst,
      required this.paragraphSecond,
      required this.description});
  final Function(bool) onChanged;
  final String paragraphFirst;
  final String paragraphSecond;
  final String description;
  @override
  State<CustomSwitchDescription> createState() =>
      _CustomSwitchDescriptionState();
}

class _CustomSwitchDescriptionState extends State<CustomSwitchDescription> {
  bool isTypeShown = false; 

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomText.darkBlueTitle(
          widget.description,
          fontSize: 16,
          textAlign: TextAlign.left,
        ),
        CustomQuestionModalSheetRevealer(
          paragraphFirst: widget.paragraphFirst,
          paragraphSecond: widget.paragraphSecond,
        ),
        const Spacer(),
        Switch(
          inactiveThumbColor: greyColor,
          activeTrackColor: Theme.of(context).indicatorColor,
          thumbColor: const MaterialStatePropertyAll<Color>(Colors.white),
          value: isTypeShown,
          onChanged: (value) {
            setState(() {
              isTypeShown = value;
              widget.onChanged(isTypeShown);
            });
          },
        ),
      ],
    );
  }
}
