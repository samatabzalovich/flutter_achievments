import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/common/widgets/custom_text.dart';
import 'package:flutter_achievments/core/common/widgets/custom_text_field.dart';
import 'package:flutter_achievments/core/common/widgets/custom_text_no_tr.dart';
import 'package:flutter_achievments/core/constant/colors.dart';
import 'package:flutter_achievments/generated/locale_keys.g.dart';

class CreatePageTextFields extends StatefulWidget {
  const CreatePageTextFields({super.key, required this.onChanged});

  final Function(String taskName, String taskDescription, bool isDescIncluded) onChanged;

  @override
  State<CreatePageTextFields> createState() => _CreatePageTextFieldsState();
}

class _CreatePageTextFieldsState extends State<CreatePageTextFields> {
  late FocusNode _taskNameFocusNode;
  late FocusNode _taskDeskFocusNode;
  bool isDescriptionProvided = false;
  String taskName = '';
  String taskDescription = '';

  @override
  void initState() {
    _taskNameFocusNode = FocusNode();
    _taskDeskFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _taskNameFocusNode.dispose();
    _taskDeskFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
            labelText: LocaleKeys.taskName,
            focusNode: _taskNameFocusNode,
            onChanged: (taskName) {
              this.taskName = taskName;
              widget.onChanged(taskName, taskDescription, isDescriptionProvided);
            },
            validator: (val) {
              if (val.isEmpty) {
                return false;
              }
              return true;
            },
            onSubmitted: (_) {
              _taskNameFocusNode.unfocus();
              _taskDeskFocusNode.requestFocus();
            },
            isPassword: false),
        Visibility(
            visible: isDescriptionProvided,
            maintainAnimation: true,
            maintainState: true,
            child: Padding(
              padding: const EdgeInsets.only(top: 16),
              child: CustomTextField(
                  labelText: LocaleKeys.typeTaskDescription,
                  focusNode: _taskDeskFocusNode,
                  onChanged: (taksDesk) {
                    taskDescription = taksDesk;
                    widget.onChanged(taskName, taskDescription, isDescriptionProvided);
                  },
                  validator: (val) {
                    if (val.isEmpty || val.length < 10) {
                      return false;
                    }

                    return true;
                  },
                  onSubmitted: (_) {
                    _taskDeskFocusNode.unfocus();
                  },
                  isPassword: false),
            )),
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton(
              style: ButtonStyle(
                padding:
                    MaterialStateProperty.all(const EdgeInsets.only(right: 10)),
                backgroundColor: MaterialStateProperty.all(Colors.transparent),
              ),
              onPressed: () {
                setState(() {
                  isDescriptionProvided = !isDescriptionProvided;
                });
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomTextNoTr(
                    '${isDescriptionProvided ? '-' : '+'}    ',
                    color: lightBlue2,
                    fontSize: 14,
                  ),
                  const CustomText(
                    LocaleKeys.taskDescription,
                    color: lightBlue2,
                    fontSize: 14,
                  ),
                ],
              )),
        ),
      ],
    );
  }
}