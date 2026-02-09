import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/repositories/cart_repository.dart';

class GetCartItemsCountUseCase {
  final CartRepository _repository;

  const GetCartItemsCountUseCase(this._repository);

  Future<Either<Failure, int>> call() async {
    return await _repository.getCartItemsCount();
  }
}

