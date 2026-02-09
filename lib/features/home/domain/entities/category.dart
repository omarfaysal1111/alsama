class HomeCategory {
  final int id;
  final String parent;
  final String img;
  
  const HomeCategory({
    required this.id,
    required this.parent,
    required this.img,
  });
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is HomeCategory && other.id == id;
  }
  
  @override
  int get hashCode => id.hashCode;
}

