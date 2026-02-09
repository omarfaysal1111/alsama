// import 'dart:convert';
import '../../domain/entities/cart_item.dart';
// import '../../../products/domain/entities/product.dart';
import '../../../products/data/models/product_model.dart';

class CartItemModel extends CartItem {
  const CartItemModel({
    required super.id,
    required super.product,
    required super.quantity,
    required super.addedAt,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['id']?.toString() ?? '',
      product: ProductModel.fromJson(json['product'] as Map<String, dynamic>),
      quantity: json['quantity'] as int? ?? 1,
      addedAt:
          json['addedAt'] != null
              ? DateTime.parse(json['addedAt'] as String)
              : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product': (product as ProductModel).toJson(),
      'quantity': quantity,
      'addedAt': addedAt.toIso8601String(),
    };
  }

  factory CartItemModel.fromEntity(CartItem cartItem) {
    return CartItemModel(
      id: cartItem.id,
      product:
          cartItem.product is ProductModel
              ? cartItem.product as ProductModel
              : ProductModel.fromEntity(cartItem.product),
      quantity: cartItem.quantity,
      addedAt: cartItem.addedAt,
    );
  }

  static List<CartItemModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => CartItemModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  static List<Map<String, dynamic>> toJsonList(List<CartItemModel> items) {
    return items.map((item) => item.toJson()).toList();
  }
}
