import 'package:flutter/material.dart';

class Picture extends StatelessWidget {
  final String? filename;
  const Picture({super.key, required this.filename, required this.width});

  final double width;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (filename != null) {
          return Image.network(
            filename!,
            width: width,
          );
        } else {
          return AspectRatio(
            aspectRatio: 3 / 4,
            child: SizedBox(
              width: width,
            ),
          );
        }
      },
    );
  }
}
