import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/product.dart';
import '../../domain/entities/category.dart';
import '../../domain/repositories/products_repository.dart';
import '../datasources/products_remote_datasource.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  final ProductsRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  const ProductsRepositoryImpl({
    required ProductsRemoteDataSource remoteDataSource,
    required NetworkInfo networkInfo,
  }) : _remoteDataSource = remoteDataSource,
       _networkInfo = networkInfo;

  @override
  Future<Either<Failure, List<Product>>> getProducts({
    int page = 1,
    int limit = 20,
    String? category,
    String? search,
    String? sortBy,
    String? sortOrder,
    double? minPrice,
    double? maxPrice,
  }) async {
    if (kDebugMode) {
      print('ProductsRepositoryImpl: getProducts called');
    }
    try {
      final isConnected = await _networkInfo.isConnected;
      print('ProductsRepositoryImpl: Network connected: $isConnected');

      if (isConnected) {
        print('ProductsRepositoryImpl: Calling remote data source');
        final products = await _remoteDataSource.getAllProducts();
        print(
          'ProductsRepositoryImpl: Received ${products.length} products from API',
        );

        // Apply filters
        List<Product> filteredProducts = _applyFilters(
          products,
          category: category,
          search: search,
          sortBy: sortBy,
          sortOrder: sortOrder,
          minPrice: minPrice,
          maxPrice: maxPrice,
        );

        // Apply pagination
        final startIndex = (page - 1) * limit;
        final endIndex = startIndex + limit;
        final paginatedProducts =
            filteredProducts.length > startIndex
                ? filteredProducts.sublist(
                  startIndex,
                  endIndex > filteredProducts.length
                      ? filteredProducts.length
                      : endIndex,
                )
                : <Product>[];

        return Right(paginatedProducts);
      } else {
        return const Left(NetworkFailure(message: 'No internet connection'));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message, code: e.code));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Product>> getProductById(String id) async {
    try {
      if (await _networkInfo.isConnected) {
        final product = await _remoteDataSource.getProductById(id);
        return Right(product);
      } else {
        return const Left(NetworkFailure(message: 'No internet connection'));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message, code: e.code));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getFeaturedProducts() async {
    try {
      if (await _networkInfo.isConnected) {
        final products = await _remoteDataSource.getFeaturedProducts();
        return Right(products);
      } else {
        return const Left(NetworkFailure(message: 'No internet connection'));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message, code: e.code));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getRelatedProducts(
    String productId,
  ) async {
    try {
      // For now, return products from the same category
      final result = await getProducts();
      return result.fold((failure) => Left(failure), (products) {
        if (products.isEmpty) {
          return const Left(ServerFailure(message: 'No products available'));
        }

        // Find the product to get its category
        try {
          final product = products.firstWhere(
            (p) => p.id == productId,
            orElse: () {
              // Return first product if found, otherwise throw
              if (products.isNotEmpty) {
                return products.first;
              }
              throw StateError('No products available');
            },
          );

          // Return products from the same category (excluding the current product)
          final relatedProducts =
              products
                  .where(
                    (p) =>
                        p.category.name == product.category.name &&
                        p.id != productId,
                  )
                  .take(5)
                  .toList();

          return Right(relatedProducts);
        } catch (e) {
          return Left(
            ServerFailure(message: 'Product not found: ${e.toString()}'),
          );
        }
      });
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ProductCategory>>> getCategories() async {
    try {
      if (await _networkInfo.isConnected) {
        final categories = await _remoteDataSource.getCategories();
        return Right(categories);
      } else {
        return const Left(NetworkFailure(message: 'No internet connection'));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message, code: e.code));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getModelsByCategory(
    int categoryId,
  ) async {
    try {
      if (await _networkInfo.isConnected) {
        final products = await _remoteDataSource.getModelsByCategory(categoryId);
        return Right(products);
      } else {
        return const Left(NetworkFailure(message: 'No internet connection'));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message, code: e.code));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> searchProducts(String query) async {
    try {
      if (await _networkInfo.isConnected) {
        final products = await _remoteDataSource.searchProducts(query);
        return Right(products);
      } else {
        return const Left(NetworkFailure(message: 'No internet connection'));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message, code: e.code));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  List<Product> _applyFilters(
    List<Product> products, {
    String? category,
    String? search,
    String? sortBy,
    String? sortOrder,
    double? minPrice,
    double? maxPrice,
  }) {
    List<Product> filteredProducts = List.from(products);

    // Apply category filter
    if (category != null && category.isNotEmpty) {
      final normalizedCategory = category.toLowerCase().trim();
      bool matches(String value) {
        final normalizedValue = value.toLowerCase().trim();
        return normalizedValue == normalizedCategory ||
            normalizedValue.contains(normalizedCategory) ||
            normalizedCategory.contains(normalizedValue);
      }

      filteredProducts =
          filteredProducts.where((product) {
            final categoryName = product.category.name;
            final parentName = product.parent;
            return matches(categoryName) || matches(parentName);
          }).toList();
    }

    // Apply search filter
    if (search != null && search.isNotEmpty) {
      filteredProducts =
          filteredProducts
              .where(
                (product) =>
                    product.title.toLowerCase().contains(
                      search.toLowerCase(),
                    ) ||
                    product.description.toLowerCase().contains(
                      search.toLowerCase(),
                    ),
              )
              .toList();
    }

    // Apply price range filter
    if (minPrice != null) {
      filteredProducts =
          filteredProducts
              .where((product) => product.finalPrice >= minPrice)
              .toList();
    }
    if (maxPrice != null) {
      filteredProducts =
          filteredProducts
              .where((product) => product.finalPrice <= maxPrice)
              .toList();
    }

    // Apply sorting
    if (sortBy != null && sortBy.isNotEmpty) {
      switch (sortBy.toLowerCase()) {
        case 'name':
        case 'title':
          filteredProducts.sort((a, b) => a.title.compareTo(b.title));
          break;
        case 'price':
          filteredProducts.sort((a, b) => a.price.compareTo(b.price));
          break;
        case 'rating':
          // Since we don't have rating in the API, sort by sellCount
          filteredProducts.sort((a, b) => a.sellCount.compareTo(b.sellCount));
          break;
        case 'newest':
          // Since we don't have date, sort by id (assuming higher id = newer)
          filteredProducts.sort(
            (a, b) => int.parse(b.id).compareTo(int.parse(a.id)),
          );
          break;
        default:
          break;
      }

      // Apply sort order
      if (sortOrder != null && sortOrder.toLowerCase() == 'desc') {
        filteredProducts = filteredProducts.reversed.toList();
      }
    }

    return filteredProducts;
  }
}
