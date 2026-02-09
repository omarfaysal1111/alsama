import '../../domain/entities/category.dart';

class CategoryModel extends ProductCategory {
  const CategoryModel({
    required super.id,
    required super.parent,
    required super.img,
  });
  
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as int? ?? 0,
      parent: json['parent']?.toString() ?? '',
      img: json['img']?.toString() ?? '',
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'parent': parent,
      'img': img,
    };
  }
  
  factory CategoryModel.fromEntity(ProductCategory category) {
    return CategoryModel(
      id: category.id,
      parent: category.parent,
      img: category.img,
    );
  }
}
