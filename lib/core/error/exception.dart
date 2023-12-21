import 'package:equatable/equatable.dart';


class ApiException extends Equatable implements Exception {
  final String dialogText;
  final String dialogTitle;
  final int statusCode;
  const ApiException({
    required this.dialogText,
    required this.dialogTitle,
    required this.statusCode,
  });
  @override
  List<Object?> get props => [statusCode, dialogText, dialogTitle];
}