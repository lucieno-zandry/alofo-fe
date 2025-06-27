import 'package:alofo/classes/screen.dart';
import 'package:flutter/material.dart';

class BanniereMd extends StatelessWidget {
  const BanniereMd({
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
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 30,
      children: [
        SizedBox(
          width: Screen.percentageToWidthOf(context, 30),
          child: texts[0],
        ),
        texts[1],
        Row(spacing: 40, children: actionButtons),
      ],
    );
  }
}
