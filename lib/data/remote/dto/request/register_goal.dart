class RegisterGoalRequest {
  late final String? name;
  late final double currentProgress;
  late final double goalNumber;
  late final DateTime expectedDate;
  late final String iconName;
  late final String? status;

  RegisterGoalRequest({
    required this.name,
    required this.currentProgress,
    required this.goalNumber,
    required this.expectedDate,
    required this.iconName,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'current_progress': currentProgress,
      'goal_number': goalNumber,
      'expected_date': expectedDate.toIso8601String(),
      'icon_name': iconName,
      'status': status,
    };
  }
}
