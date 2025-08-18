import 'package:alofo/classes/app_colors.dart';
import 'package:alofo/classes/screen.dart';
import 'package:alofo/functions/any_of_list_index.dart';
import 'package:alofo/functions/find_variant.dart';
import 'package:alofo/models/models.dart' as models;
import 'package:alofo/states/product_page_state.dart';
import 'package:alofo/widgets/app_container.dart';
import 'package:alofo/widgets/button/button.dart';
import 'package:alofo/widgets/input/number_input.dart';
import 'package:alofo/widgets/picture/picture.dart';
import 'package:alofo/widgets/variant_group/variant_group.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final minItemCount = 1;

class ProductPage extends StatefulWidget {
  const ProductPage({super.key, required this.productId});

  final String productId;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  void initState() {
    Get.put(ProductPageState(productId: widget.productId));
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<ProductPageState>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductPageState>(
      builder: (state) {
        models.Variant? selectedVariant = state.selectedVariant;
        List<models.VariantOption> activeVariantOptions =
            state.activeVariantOptions;
        int itemCount = state.itemCount;
        models.Product? product = state.product;

        String? pictureFilename =
            product?.images?.isNotEmpty == true
                ? product!.images!.first.filename
                : null;

        void onVariantOptionSelected(models.VariantOption variantOption) {
          if (product?.variants == null) return;

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
            findVariant(product!.variants!, newActiveVariantOptions),
          );
        }

        VoidCallback? onPressed =
            selectedVariant == null ||
                    minItemCount > itemCount ||
                    itemCount > selectedVariant.stock!
                ? null
                : () {};

        print(state.activeVariantOptions);

        return ListView(
          children: [
            AppContainer(
              child: Column(
                children: [
                  SizedBox(height: 125),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      if (state.product == null) {
                        return Center(child: CircularProgressIndicator());
                      }

                      return Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        crossAxisAlignment: WrapCrossAlignment.start,
                        runSpacing: 20,
                        spacing: 50,
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
                                if (product?.category?.title != null)
                                  Text(
                                    product!.category!.title!,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyLarge!.copyWith(
                                      color: AppColors.dark(alpha: 150),
                                    ),
                                  ),
                                if (product?.title != null)
                                  Text(
                                    product!.title!,
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
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(color: AppColors.dark()),
                                  ),
                                if (product?.description != null)
                                  Text(
                                    product!.description!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(color: AppColors.dark()),
                                  ),
                                if (product?.variantGroups != null &&
                                    product!.variantGroups!.isNotEmpty)
                                  for (var variantGroup
                                      in product.variantGroups!)
                                    VariantGroup(
                                      variantGroup: variantGroup,
                                      selectedVariant: selectedVariant,
                                      activeVariantOptions:
                                          activeVariantOptions,
                                      onVariantOptionSelected:
                                          onVariantOptionSelected,
                                    ),
                                if (selectedVariant != null)
                                  Wrap(
                                    spacing: 10,
                                    runSpacing: 10,
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
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
            ),
          ],
        );
      },
    );
  }
}
