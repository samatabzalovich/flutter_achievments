enum TaskType {
  oneTime,
  repeatable,
  permanent;

  static TaskType fromString(String value) {
    return TaskType.values.firstWhere((e) => e.name == value);
  }
}
