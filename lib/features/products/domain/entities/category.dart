class ProductCategory {
  final int id;
  final String parent;
  final String img;
  
  const ProductCategory({
    required this.id,
    required this.parent,
    required this.img,
  });
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ProductCategory && other.id == id;
  }
  
  @override
  int get hashCode => id.hashCode;
}
