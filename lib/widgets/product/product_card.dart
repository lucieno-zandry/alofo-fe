import 'package:alofo/classes/app_colors.dart';
import 'package:alofo/classes/screen.dart';
import 'package:alofo/models/models.dart' as models;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});

  final models.Product product;

  @override
  Widget build(BuildContext context) {
    models.Image? image = product.images?.first;
    models.Category? category = product.category;
    List<models.Variant>? variants = product.variants;
    double? price =
        variants != null && variants.isNotEmpty ? variants.first.price : null;

    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          width: Screen.percentageOf(
            constraints.maxWidth,
            Screen.responsive(
              width: constraints.maxWidth,
              standard: 100,
              xs: 42.5,
              sm: 28,
              md: 21.5,
              xl: 16.5,
            ),
          ),
          child: InkWell(
            onTap: () {
              context.go('/product/${product.id}');
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 5,
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child:
                      image?.filename != null
                          ? Image.network(image!.filename!, fit: BoxFit.contain)
                          : null,
                ),
                SizedBox(height: 10),
                if (product.title != null)
                  Text(
                    product.title!,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: AppColors.dark(),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                if (category?.title != null)
                  Text(
                    category!.title!,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: AppColors.dark(alpha: 150),
                    ),
                  ),
                if (price != null)
                  Text(
                    "\$$price",
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium!.copyWith(color: AppColors.dark()),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
