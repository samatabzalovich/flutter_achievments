import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Cubit<TaskState> {
  TaskBloc() : super(TaskInitial());

  
}
