import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.email,
    required super.name,
    super.phone,
    super.avatar,
    super.address,
    super.city,
    super.createdAt,
    super.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id']?.toString() ?? '',
      email: json['email'] as String? ?? '',
      name: json['name'] as String? ?? json['username'] as String? ?? '',
      phone: json['phone'] as String? ?? json['phone1'] as String?,  // Support both phone and phone1
      avatar: json['avatar'] as String?,
      address: json['address'] as String?,
      city: json['city'] as String?,
      createdAt:
          json['created_at'] != null
              ? DateTime.parse(json['created_at'] as String)
              : null,
      updatedAt:
          json['updated_at'] != null
              ? DateTime.parse(json['updated_at'] as String)
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      if (phone != null) 'phone': phone,
      if (avatar != null) 'avatar': avatar,
      if (address != null) 'address': address,
      if (city != null) 'city': city,
      if (createdAt != null) 'created_at': createdAt!.toIso8601String(),
      if (updatedAt != null) 'updated_at': updatedAt!.toIso8601String(),
    };
  }

  factory UserModel.fromEntity(User user) {
    return UserModel(
      id: user.id,
      email: user.email,
      name: user.name,
      phone: user.phone,
      avatar: user.avatar,
      address: user.address,
      city: user.city,
      createdAt: user.createdAt,
      updatedAt: user.updatedAt,
    );
  }
}
