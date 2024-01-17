import 'package:banking_app/utils/util.dart';
import 'package:flutter/material.dart';

import '../../ui/screens/goal/list_goal_screen.dart';

class Goal {
  final int id_goal;
  final String name;
  final IconData? icon;
  final double currentProgress;
  final double goalNumber;
  final GoalStatus status;
  final DateTime expected_date;

  Goal(
      {required this.id_goal,
      required this.name,
      this.icon,
      required this.currentProgress,
      required this.goalNumber,
      required this.status,
      required this.expected_date});

  factory Goal.fromJson(Map<String, dynamic> json) {
    return Goal(
      id_goal: json['id_goal'],
      name: json['name'],
      icon: Icons.home,
      // mudar para json['icon'],
      currentProgress: json['current_progress'].toDouble(),
      goalNumber: json['goal_number'].toDouble(),
      expected_date: dateFormatString(json['expected_date']),
      status: GoalStatus.ATIVO, // mudar para json['status']
    );
  }
}
