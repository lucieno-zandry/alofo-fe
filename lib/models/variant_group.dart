import 'package:alofo/models/model.dart';
import 'package:alofo/models/variant_option.dart';

class VariantGroup {
  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? productId;
  String? name;

  List<VariantOption>? variantOptions;

  VariantGroup({
    this.id,
    this.name,
    this.productId,
    this.createdAt,
    this.updatedAt,
    this.variantOptions,
  });

  static VariantGroup fromJson(Map<String, dynamic> json) {
    List<VariantOption>? variantOptions = Model.fromJsonList(
      json['variant_options'],
      VariantOption.fromJson,
    );

    return VariantGroup(
      id: json['id'] as int?,
      name: json['name'] as String?,
      productId: json['product_id'] as int?,
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
      variantOptions: variantOptions,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "product_id": productId,
      "created_at": createdAt,
      "updated_at": updatedAt,
    };
  }
}
