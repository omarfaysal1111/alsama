import '../../../products/domain/entities/product.dart';

class WishlistItem {
  final String id;
  final String title;
  final String description;
  final double price;
  final double discount;
  final String img;

  const WishlistItem({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.discount,
    required this.img,
  });

  double get finalPrice => price - discount;
  bool get hasDiscount => discount > 0;

  factory WishlistItem.fromProduct(Product product) {
    return WishlistItem(
      id: product.id,
      title: product.title,
      description: product.description,
      price: product.price,
      discount: product.discount,
      img: product.img,
    );
  }

  factory WishlistItem.fromJson(Map<String, dynamic> json) {
    return WishlistItem(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0,
      discount: (json['discount'] as num?)?.toDouble() ?? 0,
      img: json['img']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'discount': discount,
      'img': img,
    };
  }
}
