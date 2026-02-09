abstract class ProductsEvent {}

class GetProductsRequested extends ProductsEvent {
  final int page;
  final int limit;
  final String? category;
  final String? search;
  final String? sortBy;
  final String? sortOrder;
  
  GetProductsRequested({
    this.page = 1,
    this.limit = 20,
    this.category,
    this.search,
    this.sortBy,
    this.sortOrder,
  });
}

class GetProductByIdRequested extends ProductsEvent {
  final String productId;
  
  GetProductByIdRequested({required this.productId});
}

class GetFeaturedProductsRequested extends ProductsEvent {}

class GetRelatedProductsRequested extends ProductsEvent {
  final String productId;
  
  GetRelatedProductsRequested({required this.productId});
}

class GetCategoriesRequested extends ProductsEvent {}

class GetModelsByCategoryRequested extends ProductsEvent {
  final int categoryId;
  
  GetModelsByCategoryRequested({required this.categoryId});
}

class SearchProductsRequested extends ProductsEvent {
  final String query;
  
  SearchProductsRequested({required this.query});
}

class RefreshProductsRequested extends ProductsEvent {}

class LoadMoreProductsRequested extends ProductsEvent {}

class FilterProductsRequested extends ProductsEvent {
  final String? category;
  final String? search;
  final String? sortBy;
  final String? sortOrder;
  
  FilterProductsRequested({
    this.category,
    this.search,
    this.sortBy,
    this.sortOrder,
  });
}
