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
    String _asString(dynamic v) => v?.toString().trim() ?? '';
    String _firstNonEmpty(List<dynamic> values) {
      for (final value in values) {
        final parsed = _asString(value);
        if (parsed.isNotEmpty) return parsed;
      }
      return '';
    }

    final id = _firstNonEmpty([
      json['id'],
      json['custid'],
      json['customerId'],
      json['customer_id'],
    ]);
    final email = _firstNonEmpty([json['email'], json['mail']]);
    final name = _firstNonEmpty([
      json['name'],
      json['username'],
      json['ecommerceusername'],
      json['ecommercusername'],
      json['fullName'],
    ]);
    final phone = _firstNonEmpty([
      json['phone'],
      json['phone1'],
      json['mobile'],
      json['mobile1'],
      json['tel'],
    ]);
    final address = _firstNonEmpty([
      json['address'],
      json['addressLine1'],
      json['address_line_1'],
    ]);
    final city = _firstNonEmpty([json['city']]);

    return UserModel(
      id: id,
      email: email,
      name: name,
      phone: phone.isNotEmpty ? phone : null,
      avatar: json['avatar'] as String?,
      address: address.isNotEmpty ? address : null,
      city: city.isNotEmpty ? city : null,
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
