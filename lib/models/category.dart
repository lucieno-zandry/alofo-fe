import 'package:alofo/models/model.dart';
import 'package:alofo/models/product.dart';

class Category extends Model {
  int? id;
  String? title;
  int? parentId;
  DateTime? createdAt;
  DateTime? updatedAt;

  List<Category>? children;
  List<Product>? products;

  Category({
    this.id,
    this.title,
    this.parentId,
    this.children,
    this.createdAt,
    this.updatedAt,
    this.products,
  });

  static Category fromJson(Map<String, dynamic> json) {
    List<Category>? children = Model.fromJsonList(
      json['children'],
      Category.fromJson,
    );

    List<Product>? products = Model.fromJsonList(
      json['products'],
      Product.fromJson,
    );

    return Category(
      id: json['id'] as int?,
      title: json['title'] as String?,
      parentId: json['parent_id'] as int?,
      createdAt:
          json['created_at'] != null
              ? DateTime.parse(json['created_at'])
              : null,
      updatedAt:
          json['updated_at'] != null
              ? DateTime.parse(json['updated_at'])
              : null,
      children: children,
      products: products,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    var childrenJson = Model.toJsonList(children);

    return {
      "id": id,
      "title": title,
      "parent_id": parentId,
      "created_at": createdAt,
      "updated_at": updatedAt,
      "children": childrenJson,
    };
  }
}
