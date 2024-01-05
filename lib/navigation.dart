import 'package:flutter/material.dart';

Future<void> navigate(BuildContext context, String routeName,
    {Object? arguments}) async {
  await Navigator.pushNamed(context, routeName, arguments: arguments);
}

Future<void> navigateFinish(BuildContext context, String routeName,
    {Object? arguments}) async {
  await Navigator.pushReplacementNamed(context, routeName,
      arguments: arguments);
}
