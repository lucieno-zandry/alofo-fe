import 'package:alofo/classes/app_colors.dart';
import 'package:alofo/classes/screen.dart';
import 'package:flutter/material.dart';

class Service extends StatelessWidget {
  const Service({
    super.key,
    required this.imageSrc,
    required this.title,
    required this.description,
  });
  final String imageSrc;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          width: Screen.percentageOf(
            constraints.maxWidth,
            Screen.responsive(
              width: constraints.maxWidth,
              standard: 100,
              sm: 45,
              lg: 20
            ),
          ),
          child: Column(
            spacing: 5,
            children: [
              Image.asset(imageSrc, width: 60, height: 60, fit: BoxFit.contain),
              Text(
                title,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium!.copyWith(color: AppColors.dark()),
              ),
              Text(
                description,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium!.copyWith(color: AppColors.dark()),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }
}
