import 'package:alofo/http/requests.dart';
import 'package:alofo/models/category.dart';
import 'package:alofo/models/model.dart';
import 'package:get/get.dart';

class NavbarState extends GetxController {
  List<Category>? categories;

  void setCategories(List<Category>? items) {
    categories = items;
    update();
  }

  @override
  void onInit() {
    getCategoriesHierarchy().then((response) {
      if (response.data?['categories'] != null) {
        var categories = Model.fromJsonList(
          response.data!['categories'],
          Category.fromJson,
        );

        setCategories(categories);
      }
    });
    super.onInit();
  }
}
