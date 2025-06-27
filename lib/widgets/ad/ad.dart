import 'package:alofo/classes/app_colors.dart';
import 'package:alofo/classes/screen.dart';
import 'package:flutter/material.dart';

class Ad extends StatelessWidget {
  const Ad({
    super.key,
    required this.button,
    required this.description,
    required this.imageUrl,
    required this.title,
  });

  final String title;
  final String description;
  final String imageUrl;
  final Widget button;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          height: 450,
          width: Screen.percentageOf(
            constraints.maxWidth,
            Screen.responsive(
              width: MediaQuery.of(context).size.width,
              standard: 100,
              sm: 40,
              md: 30,
            ),
          ),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imageUrl),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(color: Color.fromARGB(125, 0, 0, 0)),
            child: DefaultTextStyle(
              style: TextStyle(color: AppColors.light()),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(40, 0, 40, 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 20,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: AppColors.light(),
                      ),
                    ),
                    Text(description),
                    button,
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
