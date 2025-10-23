import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/product.dart';
import '../repositories/products_repository.dart';

class SearchProductsUseCase {
  final ProductsRepository _repository;

  const SearchProductsUseCase(this._repository);

  Future<Either<Failure, List<Product>>> call(String query) async {
    if (query.isEmpty) {
      return const Left(
        ValidationFailure(message: 'Search query cannot be empty'),
      );
    }

    if (query.length < 2) {
      return const Left(
        ValidationFailure(
          message: 'Search query must be at least 2 characters',
        ),
      );
    }

    return await _repository.searchProducts(query);
  }
}
