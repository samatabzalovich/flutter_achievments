import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/common/widgets/custom_text.dart';

typedef DialogOptionBuilder<T> = Map<String, T?> Function();

Future<T?> showGenericDialog<T>({
  required BuildContext context,
  required String title,
  required String content,
  required DialogOptionBuilder<T> optionsBuilder,
}) {
  final options = optionsBuilder();
  return showDialog<T>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: CustomText.darkBlueTitle(
          title,
          fontSize: 20,
          textAlign: TextAlign.left,
        ),
        content: CustomText.darkBlueTitle(
          content,
          fontSize: 16,
          fontWeight: FontWeight.w500,
          textAlign: TextAlign.left,
        ),
        actions: options.keys.map((optionTitle) {
          final value = options[optionTitle];
          return TextButton(
            onPressed: () {
              if (value != null) {
                Navigator.of(context).pop(value);
              } else {
                Navigator.of(context).pop();
              }
            },
            child: Text(
              optionTitle,
            ),
          );
        }).toList(),
      );
    },
  );
}
