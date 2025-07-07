import 'package:alofo/classes/app_colors.dart';
import 'package:alofo/classes/screen.dart';
import 'package:alofo/models/models.dart' as models;
import 'package:alofo/widgets/app_container.dart';
import 'package:alofo/widgets/button/button.dart';
import 'package:alofo/widgets/clickable_category/clickable_category.dart';
import 'package:alofo/widgets/featured_products/featured_products.dart';
import 'package:alofo/widgets/input/range_input.dart';
import 'package:alofo/widgets/product/product_card.dart';
import 'package:flutter/material.dart';

List<models.Category> categories = [
  models.Category(
    id: 1,
    title: 'Tech',
    children: [
      models.Category(id: 3, title: 'Smartphone'),
      models.Category(id: 4, title: 'Laptop'),
      models.Category(id: 5, title: 'Gadget'),
    ],
  ),
  models.Category(
    id: 2,
    title: 'Clothing',
    children: [
      models.Category(id: 6, title: 'Men'),
      models.Category(id: 7, title: 'Women'),
      models.Category(id: 8, title: 'Childhood'),
    ],
  ),
];

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  RangeValues _currentRange = const RangeValues(0, 10000);
  String _selectedSort = 'Default Sorting';

  final List<String> _sortOptions = [
    'Default Sorting',
    'Price: Low to High',
    'Price: High to Low',
    'Newest',
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(top: 125),
      children: [
        AppContainer(
          child: LayoutBuilder(
            builder: (context, constraints) {
              double screenWidth = MediaQuery.of(context).size.width;
              List<Widget> children = [
                SizedBox(
                  width: Screen.percentageOf(
                    constraints.maxWidth,
                    Screen.responsive(
                      width: screenWidth,
                      standard: 100,
                      md: 20,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Filter by price',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      RangeInput(
                        currentRange: _currentRange,
                        onChanged: (RangeValues values) {
                          setState(() {
                            _currentRange = values;
                          });
                        },
                      ),
                      Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          Button(
                            onPressed: () {},
                            variant: 'primary',
                            child: Text('FILTER'),
                          ),
                          Text(
                            'Price: \$${_currentRange.start.round()} - \$${_currentRange.end.round()}',
                          ),
                        ],
                      ),
                      SizedBox(height: 50),
                      Text(
                        'Categories',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SizedBox(height: 10),
                      for (var category in categories)
                        ClickableCategory(category: category),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    bottom: 20,
                    left: Screen.responsive(
                      width: screenWidth,
                      standard: 0,
                      md: 50,
                    ),
                  ),
                  width: Screen.percentageOf(
                    constraints.maxWidth,
                    Screen.responsive(
                      width: screenWidth,
                      standard: 100,
                      md: 80,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Home / Store',
                        style: Theme.of(context).textTheme.titleMedium!
                            .copyWith(color: AppColors.secondary()),
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        width: constraints.maxWidth,
                        child: Wrap(
                          alignment: WrapAlignment.spaceBetween,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 10,
                          children: [
                            Text('Showing 1 - 12 of 31 results'),
                            DropdownButton<String>(
                              value: _selectedSort,
                              items:
                                  _sortOptions.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style:
                                            Theme.of(
                                              context,
                                            ).textTheme.bodyMedium,
                                      ),
                                    );
                                  }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedSort = newValue!;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        width: constraints.maxWidth,
                        child: Wrap(
                          runSpacing: 30,
                          spacing: 20,
                          children: [
                            for (var product in mockProducts)
                              ProductCard(product: product),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ];

              return Wrap(
                alignment: WrapAlignment.start,
                runSpacing: 30,
                children: children,
              );
            },
          ),
        ),
      ],
    );
  }
}
