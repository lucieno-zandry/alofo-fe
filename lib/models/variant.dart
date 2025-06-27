import 'package:alofo/models/model.dart';
import 'package:alofo/models/product.dart';
import 'package:alofo/models/promotion.dart';
import 'package:alofo/models/variant_option.dart';

class Variant {
  int? id;
  int? productId;
  String? sku;
  double? price;
  double? specialPrice;
  int? stock;
  String? image;
  DateTime? createdAt;
  DateTime? updatedAt;

  Product? product;
  List<VariantOption>? variantOptions;
  List<Promotion>? promotions;

  Variant({
    this.id,
    this.image,
    this.price,
    this.productId,
    this.sku,
    this.specialPrice,
    this.stock,
    this.createdAt,
    this.updatedAt,
    this.product,
    this.variantOptions,
    this.promotions,
  });

  static Variant fromJson(Map<String, dynamic> json) {
    Product? product =
        json['product'] != null ? Product.fromJson(json['product']) : null;

    List<VariantOption>? variantOptions = Model.fromJsonList(
      json['variant_options'],
      VariantOption.fromJson,
    );

    List<Promotion>? promotions = Model.fromJsonList(
      json['promotions'],
      Promotion.fromJson,
    );

    return Variant(
      id: json['id'] as int,
      image: json['image'] as String,
      price: json['price'] as double,
      productId: json['productId'] as int,
      createdAt:
          json['created_at'] != null
              ? DateTime.parse(json['created_at'])
              : null,
      updatedAt:
          json['updated_at'] != null
              ? DateTime.parse(json['updated_at'])
              : null,
      sku: json['sku'] as String,
      specialPrice: json['specialPrice'] as double,
      stock: json['stock'] as int,
      product: product,
      variantOptions: variantOptions,
      promotions: promotions,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "image": image,
      "price": price,
      "productId": productId,
      "sku": sku,
      "special_price": specialPrice,
      "stock": stock,
      "created_at": createdAt,
      "updated_at": updatedAt,
    };
  }
}
