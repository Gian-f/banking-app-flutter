import 'dart:io';

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

String formatDateString(String inputDate) {
  // Converte a string para um objeto DateTime
  DateTime dateTime = DateTime.parse(inputDate);

  // Formata a data para o formato desejado
  String formattedDate = "${dateTime.day.toString().padLeft(2, '0')}/"
      "${dateTime.month.toString().padLeft(2, '0')}/"
      "${dateTime.year}";

  return formattedDate;
}

String formatDate(String? date) {
  DateFormat inputFormat = DateFormat("dd/MM/yyyy");
  DateTime dateTime = inputFormat.parse(date!);
  String httpDate = HttpDate.format(dateTime);
  return httpDate;
}

String dateFormat(DateTime date) {
  final dateFormat = DateFormat('dd/MM/yyyy');
  return dateFormat.format(date);
}

DateTime dateFormatString(String date) {
  return DateTime.parse(date).toUtc();
}

DateTime dateFormatStringUtc(String date) {
  final dateFormat = DateFormat("dd/MM/yyyy");
  return dateFormat.parse(date).toUtc();
}

bool isAlreadyShown(DateTime lastShown) {
  final currentTime = DateTime.now().millisecondsSinceEpoch;
  final diffMillis = currentTime - lastShown.millisecondsSinceEpoch;
  return diffMillis < 24 * 60 * 60 * 1000;
}
