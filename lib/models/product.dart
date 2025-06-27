import 'package:alofo/models/category.dart';
import 'package:alofo/models/image.dart';
import 'package:alofo/models/model.dart';
import 'package:alofo/models/variant.dart';
import 'package:alofo/models/variant_group.dart';

class Product {
  int? id;
  String? title;
  String? description;
  int? categoryId;
  DateTime? createdAt;
  DateTime? updatedAt;

  Category? category;
  List<Variant>? variants;
  List<Image>? images;
  List<VariantGroup>? variantGroups;

  Product({
    this.id,
    this.title,
    this.categoryId,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.category,
    this.images,
    this.variants,
    this.variantGroups,
  });

  static Product fromJson(Map<String, dynamic> json) {
    Category? category =
        json['category'] != null ? Category.fromJson(json['category']) : null;
    List<Variant>? variants = Model.fromJsonList(
      json['variants'],
      Variant.fromJson,
    );
    List<Image>? images = Model.fromJsonList(
      json['images'],
      Image.fromJson,
    );
    List<VariantGroup>? variantGroups = Model.fromJsonList(
      json['variant_groups'],
      VariantGroup.fromJson,
    );

    return Product(
      id: json['id'] as int?,
      title: json['title'] as String?,
      categoryId: json['categoryId'] as int?,
      description: json['description'] as String?,
      createdAt:
          json['created_at'] != null
              ? DateTime.parse(json['created_at'])
              : null,
      updatedAt:
          json['updated_at'] != null
              ? DateTime.parse(json['updated_at'])
              : null,
      category: category,
      images: images,
      variants: variants,
      variantGroups: variantGroups,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "category_id": categoryId,
      "created_at": createdAt,
      "updated_at": updatedAt,
    };
  }
}
