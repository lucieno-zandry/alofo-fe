import 'package:alofo/models/model.dart';
import 'package:alofo/models/variant.dart';

class Promotion {
  int? id;
  double? discount;
  Enum? type;
  DateTime? startDate;
  DateTime? endDate;
  bool? isActive;
  DateTime? createdAt;
  DateTime? updatedAt;

  List<Variant>? variants;

  Promotion({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.discount,
    this.endDate,
    this.startDate,
    this.isActive,
    this.type,
    this.variants,
  });

  static Promotion fromJson(Map<String, dynamic> json) {
    List<Variant>? variants = Model.fromJsonList(
      json['variants'],
      Variant.fromJson,
    );

    return Promotion(
      id: json['id'],
      discount: json['discount'],
      endDate: json['end_date'] != null ? DateTime.parse(json['end_date']) : null,
      startDate: json['start_date'] != null ? DateTime.parse(json['start_date']) : null,
      isActive: json['is_active'],
      type: json['type'],
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
      variants: variants,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "discount": discount,
      "type": type,
      "start_date": startDate,
      "end_date": endDate,
      "is_active": isActive,
      "created_at": createdAt,
      "updated_at": updatedAt,
    };
  }
}