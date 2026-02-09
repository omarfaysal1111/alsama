import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/product.dart';
import '../repositories/products_repository.dart';

class GetModelsByCategoryUseCase {
  final ProductsRepository repository;
  
  GetModelsByCategoryUseCase(this.repository);
  
  Future<Either<Failure, List<Product>>> call(int categoryId) async {
    return await repository.getModelsByCategory(categoryId);
  }
}
