enum TaskStateEnum {
  active,
  completed,
  refused, //child refused the task
  rejected, // parent rejected the task
  redo,
  suggested,
  pending;

  static TaskStateEnum fromString(String type) {
    switch (type) {
      case 'active':
        return TaskStateEnum.active;
      case 'completed':
        return TaskStateEnum.completed;
      case 'refused':
        return TaskStateEnum.refused;
      case 'redo':
        return TaskStateEnum.redo;
      case 'pending':
        return TaskStateEnum.pending;
      case 'suggested':
        return TaskStateEnum.suggested;
      default:
        return TaskStateEnum.active;
    }
  }
}
