import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/common/widgets/custom_text.dart';
import 'package:flutter_achievments/core/enums/task_type.dart';
import 'package:flutter_achievments/core/common/widgets/custom_switch_description.dart';
import 'package:flutter_achievments/generated/locale_keys.g.dart';

class AdditionalSettings extends StatefulWidget {
  const AdditionalSettings(
      {super.key,
      required this.onAdditionalSettingsSelected,
      required this.type});
  final Function(bool withoutChecking, bool photoReport, bool placeInSkipped,
      bool mandatory) onAdditionalSettingsSelected;
  final TaskType type;
  @override
  State<AdditionalSettings> createState() => _AdditionalSettingsState();
}

class _AdditionalSettingsState extends State<AdditionalSettings> {
  bool withoutChecking = false;
  bool photoReport = false;
  bool placeInSkipped = false;
  bool mandatory = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomText.darkBlueTitle(LocaleKeys.additionalSettings),
        const SizedBox(
          height: 20,
        ),
        CustomSwitchDescription(
            onChanged: (val) {
              setState(() {
                withoutChecking = val;
                widget.onAdditionalSettingsSelected(
                    withoutChecking, photoReport, placeInSkipped, mandatory);
              });
            },
            paragraphFirst: LocaleKeys.withoutCheckingDescription,
            paragraphSecond: '',
            description: LocaleKeys.noCheck),
        const SizedBox(
          height: 16,
        ),
        if (widget.type != TaskType.permanent)
          Column(
            children: [
              CustomSwitchDescription(
                  onChanged: (val) {
                    setState(() {
                      photoReport = val;
                      widget.onAdditionalSettingsSelected(withoutChecking,
                          photoReport, placeInSkipped, mandatory);
                    });
                  },
                  paragraphFirst: LocaleKeys.photoReportDescription,
                  paragraphSecond: '',
                  description: LocaleKeys.photoReport),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        if (widget.type == TaskType.repeatable)
          Column(
            children: [
              CustomSwitchDescription(
                  onChanged: (val) {
                    setState(() {
                      mandatory = val;
                      widget.onAdditionalSettingsSelected(withoutChecking,
                          photoReport, placeInSkipped, mandatory);
                    });
                  },
                  paragraphFirst: LocaleKeys.mandatoryDescription,
                  paragraphSecond: LocaleKeys.mandatoryDescription2,
                  description: LocaleKeys.mandatory),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        CustomSwitchDescription(
            onChanged: (val) {
              setState(() {
                placeInSkipped = val;
                widget.onAdditionalSettingsSelected(
                    withoutChecking, photoReport, placeInSkipped, mandatory);
              });
            },
            paragraphFirst: LocaleKeys.placeInSkippedDescription,
            paragraphSecond: '',
            description: LocaleKeys.placeInSkipped),
      ],
    );
  }
}
