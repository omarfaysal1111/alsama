import '../../domain/entities/product.dart';
import '../../domain/entities/category.dart';

abstract class ProductsState {}

class ProductsInitial extends ProductsState {}

class ProductsLoading extends ProductsState {}

class ProductsLoaded extends ProductsState {
  final List<Product> products;
  final bool hasReachedMax;
  final int currentPage;
  final String? currentCategory;
  final String? currentSearch;
  final String? currentSortBy;
  final String? currentSortOrder;
  final double? currentMinPrice;
  final double? currentMaxPrice;
  
  ProductsLoaded({
    required this.products,
    this.hasReachedMax = false,
    this.currentPage = 1,
    this.currentCategory,
    this.currentSearch,
    this.currentSortBy,
    this.currentSortOrder,
    this.currentMinPrice,
    this.currentMaxPrice,
  });
  
  ProductsLoaded copyWith({
    List<Product>? products,
    bool? hasReachedMax,
    int? currentPage,
    String? currentCategory,
    String? currentSearch,
    String? currentSortBy,
    String? currentSortOrder,
    double? currentMinPrice,
    double? currentMaxPrice,
  }) {
    return ProductsLoaded(
      products: products ?? this.products,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      currentPage: currentPage ?? this.currentPage,
      currentCategory: currentCategory ?? this.currentCategory,
      currentSearch: currentSearch ?? this.currentSearch,
      currentSortBy: currentSortBy ?? this.currentSortBy,
      currentSortOrder: currentSortOrder ?? this.currentSortOrder,
      currentMinPrice: currentMinPrice ?? this.currentMinPrice,
      currentMaxPrice: currentMaxPrice ?? this.currentMaxPrice,
    );
  }
}

class ProductLoaded extends ProductsState {
  final Product product;
  
  ProductLoaded({required this.product});
}

class FeaturedProductsLoaded extends ProductsState {
  final List<Product> products;
  
  FeaturedProductsLoaded({required this.products});
}

class RelatedProductsLoaded extends ProductsState {
  final List<Product> products;
  
  RelatedProductsLoaded({required this.products});
}

class CategoriesLoaded extends ProductsState {
  final List<ProductCategory> categories;
  
  CategoriesLoaded({required this.categories});
}

class ModelsByCategoryLoaded extends ProductsState {
  final List<Product> products;
  final int categoryId;
  
  ModelsByCategoryLoaded({
    required this.products,
    required this.categoryId,
  });
}

class ProductsError extends ProductsState {
  final String message;
  
  ProductsError({required this.message});
}

class ProductsEmpty extends ProductsState {
  final String message;
  
  ProductsEmpty({required this.message});
}