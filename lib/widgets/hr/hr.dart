import 'package:alofo/classes/app_colors.dart';
import 'package:flutter/material.dart';

class Hr extends StatelessWidget {
  const Hr({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 50),
      color: AppColors.dark(alpha: 50),
      width: MediaQuery.of(context).size.width,
      height: 1,
    );
  }
}
