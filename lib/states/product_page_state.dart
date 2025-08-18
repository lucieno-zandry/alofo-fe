import 'package:alofo/configs/models_examples.dart';
import 'package:alofo/http/requests.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../models/models.dart' as models;

class ProductPageState extends GetxController {
  final String productId;

  ProductPageState({required this.productId});

  models.Variant? selectedVariant;
  List<models.VariantOption> activeVariantOptions = [];
  int itemCount = 1;
  models.Product? product;

  void setProduct(models.Product newProduct) {
    product = newProduct;
    update();
  }

  void setSelectedVariant(models.Variant? variant) {
    selectedVariant = variant;
    update();
  }

  void setActiveVariantOptions(List<models.VariantOption> variantOptions) {
    activeVariantOptions = variantOptions;
    update();
  }

  void setItemCount(int count) {
    itemCount = count;
    update();
  }

  @override
  void onInit() {
    showProduct(productId)
        .then((response) {
          if (response.data?['product'] != null) {
            product = models.Product.fromJson(response.data!['product']);

            if (product?.variants != null && product!.variants!.isNotEmpty) {
              selectedVariant = product!.variants!.first;

              if (selectedVariant!.variantOptions != null &&
                  selectedVariant!.variantOptions!.isNotEmpty) {
                activeVariantOptions = List.from(
                  selectedVariant!.variantOptions!,
                );
              }
            }

            update();
          } else {
            setProduct(productModelExample);
          }
        })
        .catchError((error) {
          setProduct(productModelExample);
          Fluttertoast.showToast(msg: error.toString());
        });

    super.onInit();
  }
}
