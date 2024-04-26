import 'package:flutter/cupertino.dart';
import 'package:flutter_achievments/features/task/domain/entities/task_entities/task_entity.dart';

class TaskProvider extends ChangeNotifier {
  List<TaskEntity>? _tasks;

  List<TaskEntity>? get tasks => _tasks;

  void addTask(TaskEntity task) {
    if (_tasks != null) {
      _tasks!.add(task);
      notifyListeners();
    }
  }

  void removeTask(TaskEntity task) {
    if (_tasks != null) {
      _tasks!.remove(task);
      notifyListeners();
    }
  }

  void clearTasks() {
    if (_tasks != null) {
      _tasks!.clear();
      notifyListeners();
    }
  }

  void updateTask(TaskEntity task) {
    if (_tasks != null) {
      final index = _tasks!.indexWhere((element) => element.id == task.id);
      if (index != -1) {
        _tasks![index] = task;
        notifyListeners();
      }
    }
  }

  void setTasks(List<TaskEntity> tasks) {
    _tasks = tasks;
    notifyListeners();
  }

  TaskEntity? getTaskById(String id) {
    return _tasks?.firstWhere((element) => element.id == id);
  }

  void removeTaskById(String id) {
    if (_tasks != null) {
      _tasks!.removeWhere((element) => element.id == id);
      notifyListeners();
    }
  }
}
