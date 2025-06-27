import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final Widget icon;
  final Widget? child;
  const CustomIconButton({super.key, required this.icon, this.child});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Row(spacing: 20, children: [icon, if (child != null) child!]),
    );
  }
}