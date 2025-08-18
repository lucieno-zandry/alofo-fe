import 'package:alofo/classes/app_colors.dart';
import 'package:alofo/classes/screen.dart';
import 'package:alofo/http/requests.dart';
import 'package:alofo/models/model.dart';
import 'package:alofo/models/models.dart';
import 'package:alofo/states/navbar_state.dart';
import 'package:alofo/widgets/app_container.dart';
import 'package:alofo/widgets/button/button.dart';
import 'package:alofo/widgets/clickable_category/clickable_category.dart';
import 'package:alofo/widgets/input/range_input.dart';
import 'package:alofo/widgets/no_result_found/no_result_found.dart';
import 'package:alofo/widgets/product/product_card.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key, required this.categoryId});

  final String categoryId;

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  RangeValues _currentRange = const RangeValues(0, 10000);
  String _selectedSort = 'Default Sorting';
  List<Product>? products = [];

  @override
  void initState() {
    getCategoryProducts(widget.categoryId)
        .then((response) {
          if (response.data?['products'] != null) {
            var productsJson = response.data!['products'];

            List<Product>? responseProducts = Model.fromJsonList(
              productsJson,
              Product.fromJson,
            );

            if (responseProducts == null) return;

            setState(() {
              products = responseProducts;
            });
          }
        })
        .catchError((error) {
          Fluttertoast.showToast(msg: "Failed to get products!");
        });

    super.initState();
  }

  final List<String> _sortOptions = [
    'Default Sorting',
    'Price: Low to High',
    'Price: High to Low',
    'Newest',
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavbarState>(
      builder: (state) {
        var categories = state.categories;

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
                          if (categories != null)
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
                          if (products != null)
                            SizedBox(
                              width: constraints.maxWidth,
                              child: Wrap(
                                runSpacing: 30,
                                spacing: 20,
                                children: [
                                  for (var product in products!)
                                    ProductCard(product: product),
                                ],
                              ),
                            ),
                          if (products == null)
                            Center(child: CircularProgressIndicator()),
                          if (products != null && products!.isEmpty)
                            NoResultFound(),
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
      },
    );
  }
}
