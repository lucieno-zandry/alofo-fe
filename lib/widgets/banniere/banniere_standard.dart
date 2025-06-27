import 'package:flutter/material.dart';

class BanniereStandard extends StatelessWidget {
  const BanniereStandard({
    super.key,
    required this.actionButtons,
    required this.texts,
  });

  final List<Widget> actionButtons;
  final List<Widget> texts;

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 30,
        children: [...texts, Column(spacing: 10, children: actionButtons)],
      );
  }
}
