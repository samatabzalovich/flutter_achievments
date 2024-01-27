import 'package:equatable/equatable.dart';

abstract class SystemTimeStatus extends Equatable {
  final bool isAutoDetect;
  const SystemTimeStatus({required this.isAutoDetect});

  @override
  List<Object> get props => [isAutoDetect];
}

class SystemTimeStatusAuto extends SystemTimeStatus {
  const SystemTimeStatusAuto() : super(isAutoDetect: true);
}

class SystemTimeStatusManual extends SystemTimeStatus {
  const SystemTimeStatusManual() : super(isAutoDetect: false);
}