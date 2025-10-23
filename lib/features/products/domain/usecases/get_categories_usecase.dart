import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/products_repository.dart';

class GetCategoriesUseCase {
  final ProductsRepository _repository;

  const GetCategoriesUseCase(this._repository);

  Future<Either<Failure, List<String>>> call() async {
    return await _repository.getCategories();
  }
}
