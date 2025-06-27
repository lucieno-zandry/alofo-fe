import 'package:alofo/classes/screen.dart';
import 'package:flutter/material.dart';

EdgeInsets getResponsivePadding(double width) {
  return Screen.responsive<EdgeInsets>(
    width: width,
    standard: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
    xs: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
    sm: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
    lg: const EdgeInsets.symmetric(horizontal: 40, vertical: 17),
  );
}
