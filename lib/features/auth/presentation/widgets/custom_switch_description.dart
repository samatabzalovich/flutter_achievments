import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/common/widgets/custom_text.dart';
import 'package:flutter_achievments/core/constant/colors.dart';
import 'package:flutter_achievments/features/auth/presentation/widgets/show_modal_sheet.dart';
import 'package:flutter_achievments/generated/locale_keys.g.dart';

class CustomSwitchDescription extends StatefulWidget {
  const CustomSwitchDescription({super.key, required this.onChanged, required this.paragraphFirst, required this.paragraphSecond, required this.description});
  final Function(bool) onChanged;
  final String paragraphFirst;
  final String paragraphSecond;
  final String description;
  @override
  State<CustomSwitchDescription> createState() => _CustomSwitchDescriptionState();
}

class _CustomSwitchDescriptionState extends State<CustomSwitchDescription> {
  bool isTypeShown = false; // show as a mom or dad


  @override
  Widget build(BuildContext context) {
    return Row(
          children: [
             CustomText.darkBlueTitle(
              widget.description,
              fontSize: 16,
              textAlign: TextAlign.left,
            ),
            GestureDetector(
              onTap: () {
                showCustomSheet(context,
                    paragraph1: widget.paragraphFirst, paragraph2: widget.paragraphSecond);
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