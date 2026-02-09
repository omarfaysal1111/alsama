import '../../domain/entities/order_item.dart';

class OrderItemModel extends OrderItem {
  const OrderItemModel({
    required super.id,
    required super.productId,
    required super.productTitle,
    required super.productImage,
    required super.price,
    required super.discount,
    required super.quantity,
    super.size,
    super.color,
  });
  
  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      id: json['id']?.toString() ?? '',
      productId: json['productId']?.toString() ?? json['product_id']?.toString() ?? '',
      productTitle: json['productTitle']?.toString() ?? json['product_title']?.toString() ?? '',
      productImage: json['productImage']?.toString() ?? json['product_image']?.toString() ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      discount: (json['discount'] as num?)?.toDouble() ?? 0.0,
      quantity: json['quantity'] as int? ?? 1,
      size: json['size']?.toString(),
      color: json['color']?.toString(),
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productId': productId,
      'productTitle': productTitle,
      'productImage': productImage,
      'price': price,
      'discount': discount,
      'quantity': quantity,
      if (size != null) 'size': size,
      if (color != null) 'color': color,
    };
  }
  
  factory OrderItemModel.fromEntity(OrderItem item) {
    return OrderItemModel(
      id: item.id,
      productId: item.productId,
      productTitle: item.productTitle,
      productImage: item.productImage,
      price: item.price,
      discount: item.discount,
      quantity: item.quantity,
      size: item.size,
      color: item.color,
    );
  }
}
