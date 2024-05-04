import 'package:flutter/cupertino.dart';
import 'package:flutter_achievments/features/task/domain/entities/task_entities/one_time_task_entity.dart';
import 'package:flutter_achievments/features/task/domain/entities/task_entities/permanent_task_entity.dart';
import 'package:flutter_achievments/features/task/domain/entities/task_entities/repeatable_task_entity.dart';
import 'package:flutter_achievments/features/task/domain/entities/task_entities/task_entity.dart';

//TODO: if you want to extend task types you need to adjust this provider
class TaskProvider extends ChangeNotifier {
  final Map<DateTime, List<OneTimeTaskEntity>?> _oneTimeTasks = {};
  final Map<int, List<RepeatableTaskEntity>?> _tasks = {};
  List<PermanentTaskEntity>? _permanentTasks;

  Map<DateTime, List<OneTimeTaskEntity>?> get oneTimeTasks => _oneTimeTasks;
  Map<int, List<RepeatableTaskEntity>?> get repeatableTaskEntity => _tasks;
  List<PermanentTaskEntity>? get permanentTasks => _permanentTasks;

  void setTasks(List<TaskEntity> task, DateTime selectedDate) {
    for (var element in task) {
      if (element is OneTimeTaskEntity) {
        addOneTimeTask(element, selectedDate, doesUiNeedsToBeUpdated: false);
      } else if (element is RepeatableTaskEntity) {
        for (var day in element.repeatOnDays) {
          addRepeatableTask(element, day, doesUiNeedsToBeUpdated: false);
        }
      } else if (element is PermanentTaskEntity) {
        addPermanentTask(element, doesUiNeedsToBeUpdated: false);
      }
    }

    if (_oneTimeTasks[selectedDate] == null) {
      _oneTimeTasks[selectedDate] = [];
    }

    if (_tasks[selectedDate.weekday] == null) {
      _tasks[selectedDate.weekday] = [];
    }
  }

  List<TaskEntity>? getTasksForSelectedDate(DateTime selectedDate) {
    final List<TaskEntity> tasks = [];

    if (_oneTimeTasks[selectedDate] != null) {
      tasks.addAll(_oneTimeTasks[selectedDate]!);
    } else {
      return null;
    }

    if (_tasks[selectedDate.weekday] != null) {
      tasks.addAll(_tasks[selectedDate.weekday]!);
    }

    if (_permanentTasks != null) {
      tasks.addAll(_permanentTasks!);
    }

    // sort by createdAt
    tasks.sort((a, b) => a.createdAt.compareTo(b.createdAt));

    return tasks;
  }

  void addTask(TaskEntity task, {bool doesUiNeedsToBeUpdated = true}) {
    if (task is OneTimeTaskEntity) {
      final startOfDay = DateTime(task.startTime.year, task.startTime.month,
          task.startTime.day, 0, 0, 0);
      addOneTimeTask(task, startOfDay,
          doesUiNeedsToBeUpdated: doesUiNeedsToBeUpdated);
    } else if (task is RepeatableTaskEntity) {
      for (var day in task.repeatOnDays) {
        addRepeatableTask(task, day,
            doesUiNeedsToBeUpdated: doesUiNeedsToBeUpdated);
      }
    } else if (task is PermanentTaskEntity) {
      addPermanentTask(task, doesUiNeedsToBeUpdated: doesUiNeedsToBeUpdated);
    }
  }

  void addOneTimeTask(OneTimeTaskEntity? task, DateTime startTimeDate,
      {bool doesUiNeedsToBeUpdated = true}) {
    if (_oneTimeTasks[startTimeDate] == null) {
      _oneTimeTasks[startTimeDate] = [];
    }
    if (task != null) {
      _oneTimeTasks[startTimeDate]!.add(task);
      if (doesUiNeedsToBeUpdated) {
        notifyListeners();
      }
    }
  }

  void addRepeatableTask(RepeatableTaskEntity? task, int day,
      {bool doesUiNeedsToBeUpdated = true}) {
    if (_tasks[day] == null) {
      _tasks[day] = [];
    }
    if (task != null) {
      if (!(_tasks[day]!.any(
        (element) => element.id == task.id,)
      )) {
        _tasks[day]!.add(task);
        if (doesUiNeedsToBeUpdated) {
          notifyListeners();
        }
      }
    }
  }

  void addPermanentTask(PermanentTaskEntity? task,
      {bool doesUiNeedsToBeUpdated = true}) {
    if (task != null) {
      _permanentTasks = [];
      _permanentTasks!.add(task);
      if (doesUiNeedsToBeUpdated) {
        notifyListeners();
      }
    }
  }

  void removeOneTimeTask(OneTimeTaskEntity task) {
    if (_oneTimeTasks[task.startTime] != null) {
      _oneTimeTasks[task.startTime]!.remove(task);
      notifyListeners();
    }
  }

  void removeRepeatableTask(RepeatableTaskEntity task) {
    final List<int> repeatOnDays = task.repeatOnDays;

    for (var element in repeatOnDays) {
      if (_tasks[element] != null) {
        _tasks[element]!.remove(task);
        notifyListeners();
      }
    }
  }

  void removePermanentTask(PermanentTaskEntity task) {
    if (_permanentTasks != null) {
      _permanentTasks!.remove(task);
      notifyListeners();
    }
  }

  void updateTask(TaskEntity task, String taskId) {
    if (task is OneTimeTaskEntity) {
      updateOneTimeTask((task).copyWith(id: taskId));
    } else if (task is RepeatableTaskEntity) {
      updateRepeatableTask(task.copyWith(id: taskId));
    } else if (task is PermanentTaskEntity) {
      updatePermanentTask(task.copyWith(id: taskId));
    }
  }

  void updateOneTimeTask(OneTimeTaskEntity task) {
    if (_oneTimeTasks[task.startTime] != null) {
      final index = _oneTimeTasks[task.startTime]!
          .indexWhere((element) => element.id == task.id);
      if (index != -1) {
        _oneTimeTasks[task.startTime]![index] = task;
        notifyListeners();
      }
    }
  }

  void updateRepeatableTask(RepeatableTaskEntity task) {
    final List<int> repeatOnDays = task.repeatOnDays;

    for (var element in repeatOnDays) {
      if (_tasks[element] != null) {
        final index =
            _tasks[element]!.indexWhere((element) => element.id == task.id);
        if (index != -1) {
          _tasks[element]![index] = task;
          notifyListeners();
        }
      }
    }
  }

  void updatePermanentTask(PermanentTaskEntity task) {
    if (_permanentTasks != null) {
      final index =
          _permanentTasks!.indexWhere((element) => element.id == task.id);
      if (index != -1) {
        _permanentTasks![index] = task;
        notifyListeners();
      }
    }
  }

  void clearOneTimeTasks() {
    _oneTimeTasks.clear();
    notifyListeners();
  }

  void clearRepeatableTasks() {
    _tasks.clear();
    notifyListeners();
  }

  void clearPermanentTasks() {
    _permanentTasks!.clear();
    notifyListeners();
  }

  void clearAllTasks() {
    _oneTimeTasks.clear();
    _tasks.clear();
    _permanentTasks!.clear();
    notifyListeners();
  }
}
