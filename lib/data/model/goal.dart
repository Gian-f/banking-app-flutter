import 'package:flutter/cupertino.dart';

import '../../ui/screens/goal/list_goal_screen.dart';

class Goal {
  final String name;
  final IconData icon;
  final double currentProgress;
  final double goalNumber;
  final GoalStatus status;
  final DateTime expectedDate;

  Goal(
      {required this.name,
      required this.icon,
      required this.currentProgress,
      required this.goalNumber,
      required this.status,
      required this.expectedDate});
}
