import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/product.dart';
import '../entities/category.dart';

abstract class ProductsRepository {
  Future<Either<Failure, List<Product>>> getProducts({
    int page = 1,
    int limit = 20,
    String? category,
    String? search,
    String? sortBy,
    String? sortOrder,
    double? minPrice,
    double? maxPrice,
  });
  
  Future<Either<Failure, Product>> getProductById(String id);
  
  Future<Either<Failure, List<Product>>> getFeaturedProducts();
  
  Future<Either<Failure, List<Product>>> getRelatedProducts(String productId);
  
  Future<Either<Failure, List<ProductCategory>>> getCategories();
  
  Future<Either<Failure, List<Product>>> getModelsByCategory(int categoryId);
  
  Future<Either<Failure, List<Product>>> searchProducts(String query);
}
