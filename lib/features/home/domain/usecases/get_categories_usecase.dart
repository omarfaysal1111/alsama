import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/category.dart';
import '../repositories/categories_repository.dart';

class GetCategoriesUseCase {
  final CategoriesRepository _repository;

  const GetCategoriesUseCase(this._repository);

  Future<Either<Failure, List<HomeCategory>>> call() async {
    return await _repository.getCategories();
  }
}

