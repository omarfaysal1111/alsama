import '../../domain/entities/product.dart';

class ProductModel extends Product {
  const ProductModel({
    required super.id,
    required super.title,
    required super.description,
    required super.price,
    required super.discount,
    required super.quantity,
    required super.img,
    required super.imageURLs,
    required super.parent,
    required super.brand,
    required super.category,
    required super.additionalInformation,
    required super.featured,
    required super.sellCount,
  });
  
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      discount: (json['discount'] as num?)?.toDouble() ?? 0.0,
      quantity: json['quantity'] as int? ?? 0,
      img: json['img']?.toString() ?? '',
      imageURLs: (json['imageURLs'] as List<dynamic>?)
          ?.map((e) => ProductImageModel.fromJson(e as Map<String, dynamic>))
          .toList() ?? [],
      parent: json['parent']?.toString() ?? '',
      brand: ProductBrandModel.fromJson(json['brand'] as Map<String, dynamic>? ?? {}),
      category: ProductCategoryModel.fromJson(json['category'] as Map<String, dynamic>? ?? {}),
      additionalInformation: (json['additionalInformation'] as List<dynamic>?)
          ?.map((e) => ProductAdditionalInfoModel.fromJson(e as Map<String, dynamic>))
          .toList() ?? [],
      featured: json['featured'] as bool? ?? false,
      sellCount: json['sellCount'] as int? ?? 0,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'discount': discount,
      'quantity': quantity,
      'img': img,
      'imageURLs': imageURLs.map((e) => (e as ProductImageModel).toJson()).toList(),
      'parent': parent,
      'brand': (brand as ProductBrandModel).toJson(),
      'category': (category as ProductCategoryModel).toJson(),
      'additionalInformation': additionalInformation.map((e) => (e as ProductAdditionalInfoModel).toJson()).toList(),
      'featured': featured,
      'sellCount': sellCount,
    };
  }
  
  factory ProductModel.fromEntity(Product product) {
    return ProductModel(
      id: product.id,
      title: product.title,
      description: product.description,
      price: product.price,
      discount: product.discount,
      quantity: product.quantity,
      img: product.img,
      imageURLs: product.imageURLs,
      parent: product.parent,
      brand: product.brand,
      category: product.category,
      additionalInformation: product.additionalInformation,
      featured: product.featured,
      sellCount: product.sellCount,
    );
  }
}

class ProductImageModel extends ProductImage {
  const ProductImageModel({required super.img});
  
  factory ProductImageModel.fromJson(Map<String, dynamic> json) {
    return ProductImageModel(
      img: json['img']?.toString() ?? '',
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'img': img,
    };
  }
}

class ProductBrandModel extends ProductBrand {
  const ProductBrandModel({required super.name});
  
  factory ProductBrandModel.fromJson(Map<String, dynamic> json) {
    return ProductBrandModel(
      name: json['name']?.toString() ?? 'Default Brand',
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }
}

class ProductCategoryModel extends ProductCategory {
  const ProductCategoryModel({required super.name});
  
  factory ProductCategoryModel.fromJson(Map<String, dynamic> json) {
    return ProductCategoryModel(
      name: json['name']?.toString() ?? '',
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }
}

class ProductAdditionalInfoModel extends ProductAdditionalInfo {
  const ProductAdditionalInfoModel({required super.key});
  
  factory ProductAdditionalInfoModel.fromJson(Map<String, dynamic> json) {
    return ProductAdditionalInfoModel(
      key: json['key']?.toString() ?? '',
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'key': key,
    };
  }
}
