import 'package:flutter/material.dart';

class CustomThemeData {
  static ThemeData themeData() {
    return ThemeData.light().copyWith(
        textTheme: TextTheme(
            bodyMedium:
                TextStyle(fontFamily: "Arvo", color: Colors.grey.shade800)));
  }
}
