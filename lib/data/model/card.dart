import 'dart:ui';

class CreditCard {
  final String cardType;
  final String cardNumber;
  final String cardName;
  final double balance;
  final List<Color> color;

  CreditCard({
    required this.cardType,
    required this.cardNumber,
    required this.cardName,
    required this.balance,
    required this.color,
  });
}
