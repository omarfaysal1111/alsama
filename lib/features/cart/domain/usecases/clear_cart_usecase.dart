import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/repositories/cart_repository.dart';

class ClearCartUseCase {
  final CartRepository _repository;

  const ClearCartUseCase(this._repository);

  Future<Either<Failure, void>> call() async {
    return await _repository.clearCart();
  }
}

