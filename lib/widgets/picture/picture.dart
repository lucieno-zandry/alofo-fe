import 'package:alofo/classes/app_colors.dart';
import 'package:flutter/material.dart';

class Picture extends StatelessWidget {
  final String? filename;
  const Picture({
    super.key,
    required this.filename,
    required this.width,
    this.ratio = 3 / 4,
  });

  final double width;
  final double ratio;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (filename != null) {
          return Image.network(filename!, width: width);
        } else {
          return Container(
            width: width,
            height: width * ratio,
            color: AppColors.secondary(),
          );
        }
      },
    );
  }
}
