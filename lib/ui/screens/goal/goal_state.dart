abstract class GoalUIEvent {}

class NameChanged extends GoalUIEvent {
  final String name;

  NameChanged(this.name);
}

class CurrentProgressChanged extends GoalUIEvent {
  final String currentProgress;

  CurrentProgressChanged(this.currentProgress);
}

class GoalNumberChanged extends GoalUIEvent {
  final String goalNumber;

  GoalNumberChanged(this.goalNumber);
}

class expectedDateChanged extends GoalUIEvent {
  final String expectedDate;

  expectedDateChanged(this.expectedDate);
}

class StatusChanged extends GoalUIEvent {
  final String status;

  StatusChanged(this.status);
}

class SaveGoalButtonClicked extends GoalUIEvent {}
