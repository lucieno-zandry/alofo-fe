import 'package:flutter/material.dart';

var themeData = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Color.fromARGB(255, 80, 162, 167),
  ),
  textTheme: TextTheme(
    displayLarge: TextStyle(
      fontWeight: FontWeight.bold,
    ),
    displaySmall: TextStyle(
      fontWeight: FontWeight.bold,
    ),
    titleLarge: TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
    ),
    titleSmall: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.bold,
    ),
    bodyMedium: TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.normal,
    ),
    titleMedium: TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.normal,
    ),
  ),
);
