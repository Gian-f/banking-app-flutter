import 'package:flutter/material.dart';

class Category {
  final int id;
  final String name;
  final IconData iconName;
  final double allocatedAmount;
  final double spentAmount;

  Category({
    required this.id,
    required this.name,
    required this.iconName,
    required this.allocatedAmount,
    this.spentAmount = 0.0,
  });
}
