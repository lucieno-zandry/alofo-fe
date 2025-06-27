import 'package:alofo/models/model.dart';
import 'package:alofo/models/product.dart';

class Image {
  int? id;
  String? filename;
  DateTime? createdAt;
  DateTime? updatedAt;
  
  List<Product>? products;

  Image({
    this.filename,
    this.products,
    this.id,
    this.createdAt,
    this.updatedAt,
  });

  static Image fromJson(Map<String, dynamic> json) {
    List<Product>? products = Model.fromJsonList(
      json['products'],
      Product.fromJson,
    );

    return Image(
      id: json['id'] as int?,
      filename: json['filename'] as String?,
      createdAt:
          json['created_at'] != null
              ? DateTime.parse(json['created_at'])
              : null,
      updatedAt:
          json['updated_at'] != null
              ? DateTime.parse(json['updated_at'])
              : null,
      products: products,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "filename": filename,
      "created_at": createdAt,
      "updated_at": updatedAt,
    };
  }
}
