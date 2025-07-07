import 'package:flutter/material.dart';

class PageSelector extends StatelessWidget {
  const PageSelector({super.key, required this.active, required this.children});

  final List<Widget> children;
  final int active;

  @override
  Widget build(BuildContext context) {
    return children[active];
  }
}
