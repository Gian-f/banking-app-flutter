import 'package:flutter/cupertino.dart';

class FinancialMovements {
  final String name;
  final String description;
  final String category;
  final TransactionType type;
  final IconData icon;
  final double price;
  final DateTime date;

  FinancialMovements({
    required this.name,
    required this.description,
    required this.category,
    required this.type,
    required this.icon,
    required this.price,
    required this.date,
  });
}

enum TransactionType { entrada, saida }
