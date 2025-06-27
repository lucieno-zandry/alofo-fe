import 'package:alofo/classes/app_colors.dart';
import 'package:alofo/classes/screen.dart';
import 'package:alofo/functions/any_of_list_index.dart';
import 'package:alofo/functions/find_variant.dart';
import 'package:alofo/models/models.dart' as models;
import 'package:alofo/widgets/app_container.dart';
import 'package:alofo/widgets/button/button.dart';
import 'package:alofo/widgets/input/number_input.dart';
import 'package:alofo/widgets/picture/picture.dart';
import 'package:alofo/widgets/variant_group/variant_group.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Example Product instance based on your models

final product = models.Product(
  id: 1,
  title: "Sample T-Shirt",
  description: "A comfortable cotton t-shirt.",
  categoryId: 10,
  createdAt: DateTime.now(),
  updatedAt: DateTime.now(),
  category: models.Category(
    id: 10,
    title: "Clothing",
    parentId: null,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    children: [],
    products: [],
  ),
  images: [
    models.Image(
      id: 100,
      filename: "https://picsum.photos/1000/1000",
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      products: [],
    ),
  ],
  variants: [
    models.Variant(
      id: 1000,
      productId: 1,
      sku: "TSHIRT-BLACK-M",
      price: 19.99,
      specialPrice: 15.99,
      stock: 1,
      image: "https://picsum.photos/200/300",
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      product: null,
      variantOptions: [
        models.VariantOption(id: 1, value: "M", variantGroupId: 200),
        models.VariantOption(id: 3, value: "BLACK", variantGroupId: 201),
      ],
      promotions: [],
    ),
    models.Variant(
      id: 1001,
      productId: 1,
      sku: "TSHIRT-BLACK-L",
      price: 23.99,
      specialPrice: 18.99,
      stock: 10,
      image: "https://picsum.photos/200/300",
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      product: null,
      variantOptions: [
        models.VariantOption(id: 2, value: "L", variantGroupId: 200),
        models.VariantOption(id: 3, value: "BLACK", variantGroupId: 201),
      ],
      promotions: [],
    ),
    models.Variant(
      id: 1002,
      productId: 1,
      sku: "TSHIRT-WHITE-M",
      price: 19.99,
      specialPrice: 15.99,
      stock: 50,
      image: "https://picsum.photos/200/300",
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      product: null,
      variantOptions: [
        models.VariantOption(id: 1, value: "M", variantGroupId: 200),
        models.VariantOption(id: 4, value: "WHITE", variantGroupId: 201),
      ],
      promotions: [],
    ),
    models.Variant(
      id: 1003,
      productId: 1,
      sku: "TSHIRT-WHITE-L",
      price: 23.99,
      specialPrice: 18.99,
      stock: 10,
      image: "https://picsum.photos/200/300",
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      product: null,
      variantOptions: [
        models.VariantOption(id: 2, value: "L", variantGroupId: 200),
        models.VariantOption(id: 4, value: "WHITE", variantGroupId: 201),
      ],
      promotions: [],
    ),
  ],
  variantGroups: [
    models.VariantGroup(
      id: 200,
      name: "Size",
      productId: 1,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      variantOptions: [
        models.VariantOption(id: 1, value: "M", variantGroupId: 200),
        models.VariantOption(id: 2, value: "L", variantGroupId: 200),
      ],
    ),
    models.VariantGroup(
      id: 201,
      name: "Colors",
      productId: 1,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      variantOptions: [
        models.VariantOption(id: 3, value: "BLACK", variantGroupId: 201),
        models.VariantOption(id: 4, value: "WHITE", variantGroupId: 201),
      ],
    ),
  ],
);

final minItemCount = 1;

class ProductPageState extends ChangeNotifier {
  models.Variant? selectedVariant;
  List<models.VariantOption> activeVariantOptions = [];
  int itemCount = 1;

  ProductPageState() {
    // Initialize selectedVariant and activeVariantOptions only once
    if (product.variants != null && product.variants!.isNotEmpty) {
      selectedVariant = product.variants!.first;

      if (selectedVariant!.variantOptions != null &&
          selectedVariant!.variantOptions!.isNotEmpty) {
        activeVariantOptions = List.from(selectedVariant!.variantOptions!);
      }
    }
  }

  void setSelectedVariant(models.Variant? variant) {
    selectedVariant = variant;
    notifyListeners();
  }

  void setActiveVariantOptions(List<models.VariantOption> variantOptions) {
    activeVariantOptions = variantOptions;
    notifyListeners();
  }

  void updateActiveVariantOptions(
    List<models.VariantOption> Function(
      List<models.VariantOption> variantOptions,
    )
    callback,
  ) {
    setActiveVariantOptions(callback(activeVariantOptions));
  }

  void setItemCount(int count) {
    itemCount = count;
    notifyListeners();
  }
}

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProductPageState(),
      child: Builder(
        builder: (context) {
          var state = context.watch<ProductPageState>();
          var selectedVariant = state.selectedVariant;
          var activeVariantOptions = state.activeVariantOptions;
          var itemCount = state.itemCount;

          String? pictureFilename = product.images?.first.filename;

          void onVariantOptionSelected(models.VariantOption variantOption) {
            if (product.variants == null) return;

            int index = anyOfListIndex(activeVariantOptions, (
              activeVariantOption,
            ) {
              return activeVariantOption.variantGroupId ==
                  variantOption.variantGroupId;
            });

            List<models.VariantOption> newActiveVariantOptions = List.from(
              activeVariantOptions,
            );

            if (index == -1) {
              newActiveVariantOptions.add(variantOption);
            } else {
              newActiveVariantOptions[index] = variantOption;
            }
            state.setActiveVariantOptions(newActiveVariantOptions);
            state.setSelectedVariant(
              findVariant(product.variants!, newActiveVariantOptions),
            );
          }

          VoidCallback? onPressed =
              selectedVariant == null ||
                      minItemCount > itemCount ||
                      itemCount > selectedVariant.stock!
                  ? null
                  : () {};

          return AppContainer(
            child: ListView(
              children: [
                SizedBox(height: 125),
                LayoutBuilder(
                  builder: (context, constraints) {
                    return Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      runSpacing: 20,
                      children: [
                        Picture(
                          filename: pictureFilename,
                          width: Screen.percentageOf(
                            constraints.maxWidth,
                            Screen.responsive(
                              width: constraints.maxWidth,
                              standard: 100,
                              md: 45,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: Screen.percentageOf(
                            constraints.maxWidth,
                            Screen.responsive(
                              width: constraints.maxWidth,
                              standard: 100,
                              md: 45,
                            ),
                          ),
                          child: Column(
                            spacing: 10,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (product.category?.title != null)
                                Text(
                                  product.category!.title!,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.bodyLarge!.copyWith(
                                    color: AppColors.dark(alpha: 150),
                                  ),
                                ),
                              if (product.title != null)
                                Text(
                                  product.title!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall!
                                      .copyWith(color: AppColors.dark()),
                                ),
                              if (selectedVariant != null)
                                Text(
                                  "\$${selectedVariant.price.toString()}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(color: AppColors.dark()),
                                ),

                              if (selectedVariant != null)
                                Text(
                                  "Selected : ${selectedVariant.sku}",
                                  style: Theme.of(context).textTheme.titleSmall!
                                      .copyWith(color: AppColors.dark()),
                                ),
                              if (product.description != null)
                                Text(
                                  product.description!,
                                  style: Theme.of(context).textTheme.bodyLarge!
                                      .copyWith(color: AppColors.dark()),
                                ),
                              if (product.variantGroups != null &&
                                  product.variantGroups!.isNotEmpty)
                                for (var variantGroup in product.variantGroups!)
                                  VariantGroup(
                                    variantGroup: variantGroup,
                                    selectedVariant: selectedVariant,
                                    activeVariantOptions: activeVariantOptions,
                                    onVariantOptionSelected:
                                        onVariantOptionSelected,
                                  ),
                              if (selectedVariant != null)
                                Wrap(
                                  spacing: 10,
                                  runSpacing: 10,
                                  children: [
                                    SizedBox(
                                      width: 125,
                                      child: NumberInput(
                                        max: selectedVariant.stock!,
                                        min: minItemCount,
                                        value: itemCount,
                                        onChanged: state.setItemCount,
                                      ),
                                    ),
                                    Button(
                                      onPressed: onPressed,
                                      variant: 'primary',
                                      child: Text('ADD TO CART'),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(height: 100),
              ],
            ),
          );
        },
      ),
    );
  }
}
