import 'package:alofo/configs/router.dart';
import 'package:alofo/configs/theme_data.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(theme: themeData, routerConfig: router);
  }
}
