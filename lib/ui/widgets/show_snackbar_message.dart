import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

showSnackbarMessage({
  required BuildContext context,
  required String message,
  Color? color,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message.tr(),
        style: const TextStyle(fontSize: 14),
        textAlign: TextAlign.center,
      ),
      backgroundColor: color,
    ),
  );
}