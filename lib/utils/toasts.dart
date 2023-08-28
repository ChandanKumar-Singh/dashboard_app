
// snackBar Widget
import 'package:flutter/material.dart';

snackBar(String? message,BuildContext context,{Color? bgColor }) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message!),
      backgroundColor: bgColor,
      duration: const Duration(seconds: 2),
    ),
  );
}