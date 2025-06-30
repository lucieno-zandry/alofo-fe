import 'package:alofo/models/models.dart' as models;
import 'package:alofo/widgets/anchor/anchor.dart';
import 'package:flutter/material.dart';

class ClickableCategory extends StatelessWidget {
  const ClickableCategory({super.key, required this.category, this.level = 0});
  final models.Category category;
  final int level;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: level * 16.0),
          child: Anchor(
            href: 'category/${category.id}',
            child: Text(category.title!),
          ),
        ),
        if (category.children != null && category.children!.isNotEmpty)
          ...category.children!.map(
            (child) => ClickableCategory(category: child, level: level + 1),
          ),
      ],
    );
  }
}
