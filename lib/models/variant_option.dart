import 'package:alofo/models/model.dart';
import 'package:alofo/models/variant.dart';
import 'package:alofo/models/variant_group.dart';

class VariantOption {
  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? value;
  int? variantGroupId;

  List<Variant>? variants;
  VariantGroup? variantGroup;

  VariantOption({
    this.id,
    this.value,
    this.variantGroupId,
    this.createdAt,
    this.updatedAt,
    this.variants,
    this.variantGroup,
  });

  static VariantOption fromJson(Map<String, dynamic> json) {
    List<Variant>? variants = Model.fromJsonList(
      json['variants'],
      Variant.fromJson,
    );
    VariantGroup? variantGroup = json['variant_group'];

    return VariantOption(
      id: json['id'],
      value: json['value'],
      variantGroupId: json['variant_group_id'],
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
      variants: variants,
      variantGroup: variantGroup,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "value": value,
      "variant_group_id": variantGroupId,
      "created_at": createdAt,
      "updated_at": updatedAt,
    };
  }
}
