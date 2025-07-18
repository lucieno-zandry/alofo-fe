class User {
  int? id;
  String? name;
  String? email;
  DateTime? emailVerifiedAt;
  DateTime? approvedAt;
  String? role;
  String? image;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? addressId;
  int? clientCodeId;
  String? password;

  User({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.approvedAt,
    this.role,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.addressId,
    this.clientCodeId,
    this.password,
  });

  static User fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      emailVerifiedAt:
          json['email_verified_at'] != null
              ? DateTime.parse(json['email_verified_at'])
              : null,
      approvedAt:
          json['approved_at'] != null
              ? DateTime.parse(json['approved_at'])
              : null,
      createdAt:
          json['created_at'] != null
              ? DateTime.parse(json['created_at'])
              : null,
      updatedAt:
          json['updated_at'] != null
              ? DateTime.parse(json['updated_at'])
              : null,
      addressId: json['address_id'],
      clientCodeId: json['client_code_id'],
      role: json['role'] ?? 'client',
      image: json['image'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'email_verified_at': emailVerifiedAt?.toIso8601String(),
      'approved_at': approvedAt?.toIso8601String(),
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'address_id': addressId,
      'client_code_id': clientCodeId,
      'role': role,
      'image': image,
      'password': password,
    };
  }
}
