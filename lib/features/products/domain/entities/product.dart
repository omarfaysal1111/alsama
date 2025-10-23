class Product {
  final String id;
  final String title;
  final String description;
  final double price;
  final double discount;
  final int quantity;
  final String img;
  final List<ProductImage> imageURLs;
  final String parent;
  final ProductBrand brand;
  final ProductCategory category;
  final List<ProductAdditionalInfo> additionalInformation;
  final bool featured;
  final int sellCount;
  
  const Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.discount,
    required this.quantity,
    required this.img,
    required this.imageURLs,
    required this.parent,
    required this.brand,
    required this.category,
    required this.additionalInformation,
    required this.featured,
    required this.sellCount,
  });
  
  double get finalPrice => price - discount;
  bool get isInStock => quantity > 0;
  bool get hasDiscount => discount > 0;
  double get discountPercentage => price > 0 ? (discount / price) * 100 : 0;
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Product && other.id == id;
  }
  
  @override
  int get hashCode => id.hashCode;
}

class ProductImage {
  final String img;
  
  const ProductImage({required this.img});
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ProductImage && other.img == img;
  }
  
  @override
  int get hashCode => img.hashCode;
}

class ProductBrand {
  final String name;
  
  const ProductBrand({required this.name});
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ProductBrand && other.name == name;
  }
  
  @override
  int get hashCode => name.hashCode;
}

class ProductCategory {
  final String name;
  
  const ProductCategory({required this.name});
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ProductCategory && other.name == name;
  }
  
  @override
  int get hashCode => name.hashCode;
}

class ProductAdditionalInfo {
  final String key;
  
  const ProductAdditionalInfo({required this.key});
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ProductAdditionalInfo && other.key == key;
  }
  
  @override
  int get hashCode => key.hashCode;
}
