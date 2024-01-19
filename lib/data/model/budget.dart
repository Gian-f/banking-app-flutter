import 'budget_category.dart';

class Budget {
  final int id;
  final String name;
  final double initialAmount;
  final double currentAmount;
  DateTime startDate;
  DateTime endDate;
  final Category category;

  Budget({
    required this.id,
    required this.name,
    this.initialAmount = 0.0,
    this.currentAmount = 0.0,
    required this.startDate,
    required this.endDate,
    required this.category,
  });
}
