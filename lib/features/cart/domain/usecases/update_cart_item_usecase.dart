import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/cart_item.dart';
import '../../domain/repositories/cart_repository.dart';

class UpdateCartItemUseCase {
  final CartRepository _repository;

  const UpdateCartItemUseCase(this._repository);

  Future<Either<Failure, CartItem>> call(String cartItemId, int quantity) async {
    return await _repository.updateCartItem(cartItemId, quantity);
  }
}

