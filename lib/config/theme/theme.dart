import 'package:flutter/material.dart';

class CustomThemeData {
  static const String fontFamily = "Ubuntu";
  static const Color textColor = Colors.black87;
  static ThemeData themeData() {
    return ThemeData.light().copyWith(
        inputDecorationTheme: const InputDecorationTheme(
            hintStyle: TextStyle(fontSize: 14, fontFamily: fontFamily)),
        textTheme: TextTheme(
            bodyMedium: TextStyle(
                fontSize: 10,
                fontFamily: fontFamily,
                color: Colors.grey.shade900)),
        listTileTheme: ListTileThemeData(
            contentPadding: EdgeInsets.zero,
            titleTextStyle: TextStyle(
                fontSize: 10,
                fontFamily: fontFamily,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade900),
            subtitleTextStyle: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w600,
                fontFamily: fontFamily,
                color: Colors.grey.shade800)));
  }
}
