import 'package:flutter/material.dart';

class Screen {
  static double xs = 320;
  static double sm = 576;
  static double md = 768;
  static double lg = 992;
  static double xl = 1200;
  static double xxl = 1400;

  static double percentageToHeightOf(BuildContext context, double percentage) {
    return MediaQuery.of(context).size.height * percentage / 100;
  }

  static double percentageToWidthOf(BuildContext context, double percentage) {
    return MediaQuery.of(context).size.width * percentage / 100;
  }

  static double percentageOf(double size, double percentage) {
    return size * percentage / 100;
  }

  static T responsive<T>({
    required double width,
    required T standard,
    T? xs,
    T? sm,
    T? md,
    T? lg,
    T? xl,
    T? xxl,
  }) {
    if (width < Screen.xs) {
      return standard;
    } else if (width >= Screen.xs && width < Screen.sm) {
      return xs ?? standard;
    } else if (width >= Screen.sm && width < Screen.md) {
      return sm ?? xs ?? standard;
    } else if (width >= Screen.md && width < Screen.lg) {
      return md ?? sm ?? xs ?? standard;
    } else if (width >= Screen.lg && width < Screen.xl) {
      return lg ?? md ?? sm ?? xs ?? standard;
    } else if (width >= Screen.xl && width < Screen.xxl) {
      return xl ?? lg ?? md ?? sm ?? xs ?? standard;
    }
    return xxl ?? xl ?? lg ?? md ?? sm ?? xs ?? standard;
  }

  static String getCurrentScreenType(double width) {
    if (width < Screen.xs) {
      return "standard";
    } else if (width >= Screen.xs && width < Screen.sm) {
      return "xs";
    } else if (width >= Screen.sm && width < Screen.md) {
      return "sm";
    } else if (width >= Screen.md && width < Screen.lg) {
      return "md";
    } else if (width >= Screen.lg && width < Screen.xl) {
      return "lg";
    } else if (width >= Screen.xl && width < Screen.xxl) {
      return "xl";
    }

    return "xxl";
  }

  /// Clamps [preferred] between [min] and [max], like CSS clamp().
  static double clamp(double min, double preferred, double max) {
    return preferred.clamp(min, max);
  }
}
