import 'package:flutter/cupertino.dart';

class Goal {
  final String name;
  final IconData icon;
  final double currentProgress;
  final double goalNumber;
  final DateTime expectedDate;

  Goal(
      {required this.name,
      required this.icon,
      required this.currentProgress,
      required this.goalNumber,
      required this.expectedDate});
}
