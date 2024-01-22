import 'package:flutter/material.dart';

Material customIconButton(
  double borderRadius,
  Function() onClick,
  IconData icon,
  BuildContext context, {
  double size = 25,
}) {
  return Material(
    color: Colors.transparent,
    child: InkWell(
      borderRadius: BorderRadius.circular(borderRadius),
      onTap: onClick,
      child: Ink(
        padding: const EdgeInsets.all(9),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceVariant,
            borderRadius: BorderRadius.circular(borderRadius)),
        child: Icon(
          icon,
          size: size,
        ),
      ),
    ),
  );
}

void showSnackbar(BuildContext context, Widget content, {String label = "Ok"}) {
  final snackBar = SnackBar(
    content: content,
    action: SnackBarAction(
      label: label,
      onPressed: () {},
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
