import 'package:alofo/classes/screen.dart';
import 'package:alofo/widgets/app_container.dart';
import 'package:alofo/widgets/product/product_card.dart';
import 'package:flutter/material.dart';
import 'package:alofo/models/models.dart' as models;

final List<models.Product> mockProducts = [
  models.Product(
    id: 1,
    title: 'Product A',
    description: 'A great product',
    categoryId: 10,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    category: models.Category(id: 10, title: 'Category 1'),
    images: [
      models.Image(
        id: 100,
        filename: 'assets/images/a.jpg',
        createdAt: DateTime.now(),
      ),
    ],
    variants: [
      models.Variant(
        id: 1000,
        sku: 'SKU-A1',
        price: 19.99,
        specialPrice: 17.99,
        stock: 50,
        image: 'a.jpg',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        variantOptions: [
          models.VariantOption(
            id: 5000,
            value: 'Small',
            variantGroupId: 200,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
        ],
      ),
    ],
    variantGroups: [
      models.VariantGroup(
        id: 200,
        name: 'Size',
        variantOptions: [
          models.VariantOption(
            id: 5000,
            value: 'Small',
            variantGroupId: 200,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
          models.VariantOption(
            id: 5001,
            value: 'Large',
            variantGroupId: 200,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
        ],
      ),
    ],
  ),
  models.Product(
    id: 2,
    title: 'Product B',
    description: 'Another product',
    categoryId: 20,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    category: models.Category(id: 20, title: 'Category 2'),
    images: [
      models.Image(
        id: 101,
        filename: 'assets/images/b.jpg',
        createdAt: DateTime.now(),
      ),
    ],
    variants: [
      models.Variant(
        id: 1001,
        sku: 'SKU-B1',
        price: 29.99,
        specialPrice: 25.99,
        stock: 30,
        image: 'b.jpg',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        variantOptions: [
          models.VariantOption(
            id: 6000,
            value: 'Red',
            variantGroupId: 201,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
        ],
      ),
    ],
    variantGroups: [
      models.VariantGroup(
        id: 201,
        name: 'Color',
        variantOptions: [
          models.VariantOption(
            id: 6000,
            value: 'Red',
            variantGroupId: 201,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
          models.VariantOption(
            id: 6001,
            value: 'Blue',
            variantGroupId: 201,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
        ],
      ),
    ],
  ),
  models.Product(
    id: 3,
    title: 'Product C',
    description: 'Another product',
    categoryId: 20,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    category: models.Category(id: 20, title: 'Category 2'),
    images: [
      models.Image(
        id: 102,
        filename: 'assets/images/a.jpg',
        createdAt: DateTime.now(),
      ),
    ],
    variants: [
      models.Variant(
        id: 1002,
        sku: 'SKU-B1',
        price: 29.99,
        specialPrice: 25.99,
        stock: 30,
        image: 'b.jpg',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        variantOptions: [
          models.VariantOption(
            id: 6000,
            value: 'Red',
            variantGroupId: 201,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
        ],
      ),
    ],
    variantGroups: [
      models.VariantGroup(
        id: 202,
        name: 'Color',
        variantOptions: [
          models.VariantOption(
            id: 6001,
            value: 'Red',
            variantGroupId: 201,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
          models.VariantOption(
            id: 6002,
            value: 'Blue',
            variantGroupId: 201,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
        ],
      ),
    ],
  ),
  models.Product(
    id: 4,
    title: 'Product D',
    description: 'Another product',
    categoryId: 20,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    category: models.Category(id: 20, title: 'Category 2'),
    images: [
      models.Image(
        id: 103,
        filename: 'assets/images/b.jpg',
        createdAt: DateTime.now(),
      ),
    ],
    variants: [
      models.Variant(
        id: 1004,
        sku: 'SKU-B1',
        price: 29.99,
        specialPrice: 25.99,
        stock: 30,
        image: 'a.jpg',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        variantOptions: [
          models.VariantOption(
            id: 6003,
            value: 'Red',
            variantGroupId: 201,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
        ],
      ),
    ],
    variantGroups: [
      models.VariantGroup(
        id: 204,
        name: 'Color',
        variantOptions: [
          models.VariantOption(
            id: 6005,
            value: 'Red',
            variantGroupId: 201,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
          models.VariantOption(
            id: 6006,
            value: 'Blue',
            variantGroupId: 201,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
        ],
      ),
    ],
  ),
  models.Product(
    id: 4,
    title: 'Product D',
    description: 'Another product',
    categoryId: 20,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    category: models.Category(id: 20, title: 'Category 2'),
    images: [
      models.Image(
        id: 103,
        filename: 'assets/images/b.jpg',
        createdAt: DateTime.now(),
      ),
    ],
    variants: [
      models.Variant(
        id: 1004,
        sku: 'SKU-B1',
        price: 29.99,
        specialPrice: 25.99,
        stock: 30,
        image: 'a.jpg',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        variantOptions: [
          models.VariantOption(
            id: 6003,
            value: 'Red',
            variantGroupId: 201,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
        ],
      ),
    ],
    variantGroups: [
      models.VariantGroup(
        id: 204,
        name: 'Color',
        variantOptions: [
          models.VariantOption(
            id: 6005,
            value: 'Red',
            variantGroupId: 201,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
          models.VariantOption(
            id: 6006,
            value: 'Blue',
            variantGroupId: 201,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
        ],
      ),
    ],
  ),
];

class FeaturedProducts extends StatelessWidget {
  const FeaturedProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50),
        child: Column(
          children: [
            Text(
              'Featured Products',
              style: Theme.of(
                context,
              ).textTheme.displaySmall!.copyWith(color: Colors.black),
            ),
            Container(
              height: 2,
              width: Screen.clamp(
                50,
                Screen.percentageOf(MediaQuery.of(context).size.width, 20),
                1000,
              ),
              margin: EdgeInsets.symmetric(vertical: 25),
              color: Colors.blue,
            ),
            Wrap(
              spacing: 50,
              runSpacing: 50,
              alignment: WrapAlignment.spaceAround,
              children: [
                for (var mockProduct in mockProducts)
                  ProductCard(product: mockProduct),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
