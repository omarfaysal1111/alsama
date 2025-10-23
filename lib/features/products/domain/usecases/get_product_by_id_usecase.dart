import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/product.dart';
import '../repositories/products_repository.dart';

class GetProductByIdUseCase {
  final ProductsRepository _repository;

  const GetProductByIdUseCase(this._repository);

  Future<Either<Failure, Product>> call(String id) async {
    if (id.isEmpty) {
      return const Left(
        ValidationFailure(message: 'Product ID cannot be empty'),
      );
    }

    return await _repository.getProductById(id);
  }
}
