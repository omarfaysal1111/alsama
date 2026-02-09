import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/repositories/cart_repository.dart';

class RemoveFromCartUseCase {
  final CartRepository _repository;

  const RemoveFromCartUseCase(this._repository);

  Future<Either<Failure, void>> call(String cartItemId) async {
    return await _repository.removeFromCart(cartItemId);
  }
}

