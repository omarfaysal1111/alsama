import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/product.dart';
import '../repositories/products_repository.dart';

class GetProductsUseCase {
  final ProductsRepository _repository;

  const GetProductsUseCase(this._repository);

  Future<Either<Failure, List<Product>>> call({
    int page = 1,
    int limit = 20,
    String? category,
    String? search,
    String? sortBy,
    String? sortOrder,
  }) async {
    if (page < 1) {
      return const Left(
        ValidationFailure(message: 'Page must be greater than 0'),
      );
    }

    if (limit < 1 || limit > 100) {
      return const Left(
        ValidationFailure(message: 'Limit must be between 1 and 100'),
      );
    }

    return await _repository.getProducts(
      page: page,
      limit: limit,
      category: category,
      search: search,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }
}
