import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/common/dialogs/generic_dialog.dart';

Future<void> showErrorDialog({
  required String dialogTitle,
    required String dialogText,

  required BuildContext context,
}) =>
    showGenericDialog(
      context: context,
      title: dialogTitle,
      content: dialogText,
      optionsBuilder: () => {
        'OK': true,
      },
    );