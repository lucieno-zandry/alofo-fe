import 'package:flutter/material.dart';

void debug(BuildContext context, Object? message) {
  // Print to console (in case it works)
  print(message);

  // Show in-app SnackBar
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message.toString()),
      duration: const Duration(seconds: 60),
    ),
  );
}
