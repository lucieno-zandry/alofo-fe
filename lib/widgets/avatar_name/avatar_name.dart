import 'package:flutter/material.dart';

class AvatarName extends StatelessWidget {
  final String name;
  final double radius;
  final Color? circleColor;
  final TextStyle? textStyle;

  const AvatarName({
    super.key,
    required this.name,
    this.radius = 15,
    this.circleColor,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final String firstLetter = (name.isNotEmpty ? name[0].toUpperCase() : '?');
    final Color bgColor = circleColor ?? Theme.of(context).primaryColor;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: radius,
          backgroundColor: bgColor,
          child: Text(
            firstLetter,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: radius,
            ),
          ),
        ),
        SizedBox(width: 5),
        Text(name, style: textStyle ?? Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}
