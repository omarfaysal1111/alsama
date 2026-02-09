import '../../../products/domain/entities/product.dart';

class CartItem {
  final String id;
  final Product product;
  final int quantity;
  final DateTime addedAt;
  
  const CartItem({
    required this.id,
    required this.product,
    required this.quantity,
    required this.addedAt,
  });
  
  double get totalPrice => product.finalPrice * quantity;
  double get totalDiscount => product.discount * quantity;
  double get subtotal => product.price * quantity;
  
  CartItem copyWith({
    String? id,
    Product? product,
    int? quantity,
    DateTime? addedAt,
  }) {
    return CartItem(
      id: id ?? this.id,
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      addedAt: addedAt ?? this.addedAt,
    );
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CartItem && other.id == id;
  }
  
  @override
  int get hashCode => id.hashCode;
}

