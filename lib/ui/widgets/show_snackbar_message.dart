import 'package:flutter/material.dart';

showSnackbarMessage({
  required  context,
  required String message,
  Color? color,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: TextStyle(fontSize: 14),
        textAlign: TextAlign.center,
      ),
      backgroundColor: color,
    ),
  );
}
