import 'package:flutter/material.dart';

class CustomTextIconButton extends StatelessWidget {
  final Widget icon;
  final Widget? child;
  const CustomTextIconButton({super.key, required this.icon, this.child});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Row(spacing: 20, children: [icon, if (child != null) child!]),
    );
  }
}
