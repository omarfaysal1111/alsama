import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String email;
  final String name;
  final String? phone;
  final String? avatar;
  final String? address;
  final String? city;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const User({
    required this.id,
    required this.email,
    required this.name,
    this.phone,
    this.avatar,
    this.address,
    this.city,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        email,
        name,
        phone,
        avatar,
        address,
        city,
        createdAt,
        updatedAt,
      ];

  User copyWith({
    String? id,
    String? email,
    String? name,
    String? phone,
    String? avatar,
    String? address,
    String? city,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      avatar: avatar ?? this.avatar,
      address: address ?? this.address,
      city: city ?? this.city,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
