class OrderItem {
  final String id;
  final String productId;
  final String productTitle;
  final String productImage;
  final double price;
  final double discount;
  final int quantity;
  final String? size;
  final String? color;
  
  const OrderItem({
    required this.id,
    required this.productId,
    required this.productTitle,
    required this.productImage,
    required this.price,
    required this.discount,
    required this.quantity,
    this.size,
    this.color,
  });
  
  double get subtotal => price * quantity;
  double get totalDiscount => discount * quantity;
  double get total => (price - discount) * quantity;
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is OrderItem && other.id == id;
  }
  
  @override
  int get hashCode => id.hashCode;
}
