import 'package:equatable/equatable.dart';


class ApiException extends Equatable implements Exception {
  final String dialogTextCode;
  final String dialogTitleCode;
  final int statusCode;
  const ApiException({
    required this.dialogTextCode,
    required this.dialogTitleCode,
    required this.statusCode,
  });


  @override
  List<Object?> get props => [statusCode, dialogTextCode, dialogTitleCode];
}