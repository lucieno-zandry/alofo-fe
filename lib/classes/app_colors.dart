import 'package:flutter/material.dart';

class AppColors {
  static Color light({int alpha = 255}) => Color.fromARGB(alpha, 255, 255, 255);

  static Color primary({int alpha = 255}) =>
      Color.fromARGB(alpha, 27, 125, 136);

  static Color secondary({int alpha = 255}) =>
      Color.fromARGB(alpha, 80, 162, 167);

  static Color danger({int alpha = 255}) => Color.fromARGB(alpha, 240, 100, 73);

  static Color warning({int alpha = 255}) =>
      Color.fromARGB(alpha, 233, 180, 76);

  static Color dark({int alpha = 255}) => Color.fromARGB(alpha, 28, 17, 10);

  static Color success({int alpha = 255}) => Color.fromARGB(alpha, 68, 99, 63);
}
