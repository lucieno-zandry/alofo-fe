import 'package:alofo/models/model.dart';
import 'package:alofo/models/product.dart';
import 'package:alofo/models/promotion.dart';
import 'package:alofo/models/variant_option.dart';

class Variant extends Model {
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
      id: json['id'],
      image: json['image'],
      price: json['price'],
      productId: json['product_id'],
      createdAt:
          json['created_at'] != null
              ? DateTime.parse(json['created_at'])
              : null,
      updatedAt:
          json['updated_at'] != null
              ? DateTime.parse(json['updated_at'])
              : null,
      sku: json['sku'],
      specialPrice: json['special_price'],
      stock: json['stock'],
      product: product,
      variantOptions: variantOptions,
      promotions: promotions,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "image": image,
      "price": price,
      "product_id": productId,
      "sku": sku,
      "special_price": specialPrice,
      "stock": stock,
      "created_at": createdAt,
      "updated_at": updatedAt,
    };
  }
}
