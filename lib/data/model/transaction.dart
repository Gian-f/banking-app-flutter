import 'package:flutter/cupertino.dart';

class Transaction {
  final String name;
  final String description;
  final String category;
  final TransactionType type;
  final IconData icon;
  final double price;
  final DateTime date;

  Transaction({
    required this.name,
    required this.description,
    required this.category,
    required this.type,
    required this.icon,
    required this.price,
    required this.date,
  });
}

class TransactionType {
  final String type;

  const TransactionType._(this.type);

  static const entrada = TransactionType._('entrada');
  static const saida = TransactionType._('saida');

  static const values = [entrada, saida];
}
