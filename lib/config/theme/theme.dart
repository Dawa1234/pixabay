import 'package:flutter/material.dart';

class CustomThemeData {
  static const String fontFamily = "Ubuntu";
  static const Color textColor = Colors.black87;
  static ThemeData themeData() {
    return ThemeData.light().copyWith(
        appBarTheme: AppBarTheme(
            centerTitle: true,
            titleTextStyle: TextStyle(
                fontSize: 18,
                fontFamily: fontFamily,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade900)),
        textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
                shape: const BeveledRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(2))),
                textStyle: TextStyle(
                    fontSize: 12,
                    fontFamily: fontFamily,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade900))),
        dialogTheme: DialogTheme(
            actionsPadding: const EdgeInsets.only(right: 10),
            titleTextStyle: TextStyle(
                fontSize: 12,
                fontFamily: fontFamily,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade900)),
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
