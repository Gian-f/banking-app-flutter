import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

getGradient(Color startColor, Color endColor) {
  return SweepGradient(
    center: Alignment.center,
    colors: [startColor, endColor],
  );
}

String hideCreditCardNumber(String creditCardNumber) {
  if (creditCardNumber.length <= 4) {
    return creditCardNumber;
  }
  return "**** **** **** ${creditCardNumber.substring(creditCardNumber.length - 4)}";
}

String formatDateAgo(DateTime date) {
  final currentTime = DateTime.now().millisecondsSinceEpoch;
  final diffMillis = currentTime - date.millisecondsSinceEpoch;
  final diffHours = diffMillis ~/ 1000 ~/ 60 ~/ 60;

  return diffHours < 1 ? "Agora mesmo" : "$diffHours horas atrás";
}

String formatMoney(double value) {
  final formatCurrency = NumberFormat.simpleCurrency(locale: 'pt_BR');
  return formatCurrency.format(value);
}

String dateFormat(DateTime date) {
  final dateFormat = DateFormat('dd/MM/yyyy');
  return dateFormat.format(date);
}

bool isAlreadyShown(DateTime lastShown) {
  final currentTime = DateTime.now().millisecondsSinceEpoch;
  final diffMillis = currentTime - lastShown.millisecondsSinceEpoch;
  return diffMillis < 24 * 60 * 60 * 1000;
}
