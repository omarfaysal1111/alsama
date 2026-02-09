import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/cart_item.dart';
import '../../domain/repositories/cart_repository.dart';

class AddToCartUseCase {
  final CartRepository _repository;

  const AddToCartUseCase(this._repository);

  Future<Either<Failure, CartItem>> call(CartItem cartItem) async {
    return await _repository.addToCart(cartItem);
  }
}

