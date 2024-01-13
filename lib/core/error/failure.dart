import 'package:equatable/equatable.dart';
import 'package:flutter_achievments/core/error/exception.dart';

abstract class Failure extends Equatable {
  final String dialogText;
  final String dialogTitle;
  final int statusCode;
  const Failure({
    required this.dialogText,
    required this.dialogTitle,
    required this.statusCode,
  });
  String get errorMessage => '$statusCode Error: $dialogTitle $dialogText';
  @override
  List<Object> get props => [dialogText, dialogTitle,  statusCode];
}

class ApiFailure extends Failure {
  const ApiFailure({
    required String dialogText,
    required String dialogTitle,
    required int statusCode,
  }) : super(
          dialogText: dialogText,
          dialogTitle: dialogTitle,
          statusCode: statusCode,
        );
  ApiFailure.fromException(ApiException exception)
      : this(
          dialogText: exception.dialogTextCode,
          dialogTitle: exception.dialogTitleCode,
          statusCode: exception.statusCode,
        );
}
