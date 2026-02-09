import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_products_usecase.dart';
import '../../domain/usecases/get_product_by_id_usecase.dart';
import '../../domain/usecases/search_products_usecase.dart';
import '../../domain/usecases/get_categories_usecase.dart';
import '../../domain/usecases/get_models_by_category_usecase.dart';
import 'products_event.dart';
import 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final GetProductsUseCase _getProductsUseCase;
  final GetProductByIdUseCase _getProductByIdUseCase;
  final SearchProductsUseCase _searchProductsUseCase;
  final GetCategoriesUseCase _getCategoriesUseCase;
  final GetModelsByCategoryUseCase _getModelsByCategoryUseCase;
  
  ProductsBloc({
    required GetProductsUseCase getProductsUseCase,
    required GetProductByIdUseCase getProductByIdUseCase,
    required SearchProductsUseCase searchProductsUseCase,
    required GetCategoriesUseCase getCategoriesUseCase,
    required GetModelsByCategoryUseCase getModelsByCategoryUseCase,
  }) : _getProductsUseCase = getProductsUseCase,
       _getProductByIdUseCase = getProductByIdUseCase,
       _searchProductsUseCase = searchProductsUseCase,
       _getCategoriesUseCase = getCategoriesUseCase,
       _getModelsByCategoryUseCase = getModelsByCategoryUseCase,
       super(ProductsInitial()) {
    
    on<GetProductsRequested>(_onGetProductsRequested);
    on<GetProductByIdRequested>(_onGetProductByIdRequested);
    on<GetFeaturedProductsRequested>(_onGetFeaturedProductsRequested);
    on<GetRelatedProductsRequested>(_onGetRelatedProductsRequested);
    on<GetCategoriesRequested>(_onGetCategoriesRequested);
    on<GetModelsByCategoryRequested>(_onGetModelsByCategoryRequested);
    on<SearchProductsRequested>(_onSearchProductsRequested);
    on<RefreshProductsRequested>(_onRefreshProductsRequested);
    on<LoadMoreProductsRequested>(_onLoadMoreProductsRequested);
    on<FilterProductsRequested>(_onFilterProductsRequested);
  }
  
  Future<void> _onGetProductsRequested(
    GetProductsRequested event,
    Emitter<ProductsState> emit,
  ) async {
    print('ProductsBloc: _onGetProductsRequested called');
    emit(ProductsLoading());
    
    print('ProductsBloc: Calling _getProductsUseCase');
    final result = await _getProductsUseCase(
      page: event.page,
      limit: event.limit,
      category: event.category,
      search: event.search,
      sortBy: event.sortBy,
      sortOrder: event.sortOrder,
    );
    
    print('ProductsBloc: Use case result received');
    
    result.fold(
      (failure) => emit(ProductsError(message: failure.message)),
      (products) {
        if (products.isEmpty) {
          emit(ProductsEmpty(message: 'No products found'));
        } else {
          emit(ProductsLoaded(
            products: products,
            currentPage: event.page,
            currentCategory: event.category,
            currentSearch: event.search,
            currentSortBy: event.sortBy,
            currentSortOrder: event.sortOrder,
          ));
        }
      },
    );
  }
  
  Future<void> _onGetProductByIdRequested(
    GetProductByIdRequested event,
    Emitter<ProductsState> emit,
  ) async {
    emit(ProductsLoading());
    
    final result = await _getProductByIdUseCase(event.productId);
    
    result.fold(
      (failure) => emit(ProductsError(message: failure.message)),
      (product) => emit(ProductLoaded(product: product)),
    );
  }
  
  Future<void> _onGetFeaturedProductsRequested(
    GetFeaturedProductsRequested event,
    Emitter<ProductsState> emit,
  ) async {
    emit(ProductsLoading());
    
    final result = await _getProductsUseCase();
    
    result.fold(
      (failure) => emit(ProductsError(message: failure.message)),
      (products) {
        final featuredProducts = products.where((product) => product.featured).toList();
        if (featuredProducts.isEmpty) {
          emit(ProductsEmpty(message: 'No featured products found'));
        } else {
          emit(FeaturedProductsLoaded(products: featuredProducts));
        }
      },
    );
  }
  
  Future<void> _onGetRelatedProductsRequested(
    GetRelatedProductsRequested event,
    Emitter<ProductsState> emit,
  ) async {
    emit(ProductsLoading());
    
    // Get all products first
    final result = await _getProductsUseCase();
    
    result.fold(
      (failure) => emit(ProductsError(message: failure.message)),
      (products) {
        if (products.isEmpty) {
          emit(ProductsEmpty(message: 'No products available'));
          return;
        }
        
        try {
          // Find the product to get its category
          final product = products.firstWhere(
            (p) => p.id == event.productId,
            orElse: () {
              // Return first product if found, otherwise throw
              if (products.isNotEmpty) {
                return products.first;
              }
              throw StateError('No products available');
            },
          );
          
          // Get products from the same category (excluding the current product)
          final relatedProducts = products
              .where((p) => p.category.name == product.category.name && p.id != event.productId)
              .take(5)
              .toList();
          
          if (relatedProducts.isEmpty) {
            emit(ProductsEmpty(message: 'No related products found'));
          } else {
            emit(RelatedProductsLoaded(products: relatedProducts));
          }
        } catch (e) {
          emit(ProductsError(message: 'Failed to get related products: ${e.toString()}'));
        }
      },
    );
  }
  
  Future<void> _onGetCategoriesRequested(
    GetCategoriesRequested event,
    Emitter<ProductsState> emit,
  ) async {
    emit(ProductsLoading());
    
    final result = await _getCategoriesUseCase();
    
    result.fold(
      (failure) => emit(ProductsError(message: failure.message)),
      (categories) {
        if (categories.isEmpty) {
          emit(ProductsEmpty(message: 'No categories found'));
        } else {
          emit(CategoriesLoaded(categories: categories));
        }
      },
    );
  }

  Future<void> _onGetModelsByCategoryRequested(
    GetModelsByCategoryRequested event,
    Emitter<ProductsState> emit,
  ) async {
    emit(ProductsLoading());
    
    final result = await _getModelsByCategoryUseCase(event.categoryId);
    
    result.fold(
      (failure) => emit(ProductsError(message: failure.message)),
      (products) {
        if (products.isEmpty) {
          emit(ProductsEmpty(message: 'No products found in this category'));
        } else {
          emit(ModelsByCategoryLoaded(
            products: products,
            categoryId: event.categoryId,
          ));
        }
      },
    );
  }
  
  Future<void> _onSearchProductsRequested(
    SearchProductsRequested event,
    Emitter<ProductsState> emit,
  ) async {
    emit(ProductsLoading());
    
    final result = await _searchProductsUseCase(event.query);
    
    result.fold(
      (failure) => emit(ProductsError(message: failure.message)),
      (products) {
        if (products.isEmpty) {
          emit(ProductsEmpty(message: 'No products found for "${event.query}"'));
        } else {
          emit(ProductsLoaded(
            products: products,
            currentSearch: event.query,
          ));
        }
      },
    );
  }
  
  Future<void> _onRefreshProductsRequested(
    RefreshProductsRequested event,
    Emitter<ProductsState> emit,
  ) async {
    add(GetProductsRequested());
  }
  
  Future<void> _onLoadMoreProductsRequested(
    LoadMoreProductsRequested event,
    Emitter<ProductsState> emit,
  ) async {
    final currentState = state;
    if (currentState is ProductsLoaded && !currentState.hasReachedMax) {
      add(GetProductsRequested(
        page: currentState.currentPage + 1,
        category: currentState.currentCategory,
        search: currentState.currentSearch,
        sortBy: currentState.currentSortBy,
        sortOrder: currentState.currentSortOrder,
      ));
    }
  }
  
  Future<void> _onFilterProductsRequested(
    FilterProductsRequested event,
    Emitter<ProductsState> emit,
  ) async {
    add(GetProductsRequested(
      category: event.category,
      search: event.search,
      sortBy: event.sortBy,
      sortOrder: event.sortOrder,
    ));
  }
}