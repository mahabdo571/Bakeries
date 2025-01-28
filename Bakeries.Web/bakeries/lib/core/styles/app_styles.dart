import 'package:flutter/material.dart';

class AppStyles {
  static const double defaultPadding = 16.0;
  static const double defaultRadius = 8.0;

  static InputDecoration inputDecoration({
    required String label,
    required IconData icon,
    String? helperText,
  }) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(defaultRadius),
      ),
      helperText: helperText,
    );
  }
}
