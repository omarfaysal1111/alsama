import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/product.dart';
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
        print('ProductsRepositoryImpl: Received ${products.length} products from API');

        // Apply filters
        List<Product> filteredProducts = _applyFilters(
          products,
          category: category,
          search: search,
          sortBy: sortBy,
          sortOrder: sortOrder,
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
        // Find the product to get its category
        final product = products.firstWhere(
          (p) => p.id == productId,
          orElse: () => products.first,
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
      });
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getCategories() async {
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
  }) {
    List<Product> filteredProducts = List.from(products);

    // Apply category filter
    if (category != null && category.isNotEmpty) {
      filteredProducts =
          filteredProducts
              .where(
                (product) =>
                    product.category.name.toLowerCase() ==
                    category.toLowerCase(),
              )
              .toList();
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
