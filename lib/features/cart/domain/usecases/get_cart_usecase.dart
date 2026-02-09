import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/cart_item.dart';
import '../../domain/repositories/cart_repository.dart';

class GetCartUseCase {
  final CartRepository _repository;

  const GetCartUseCase(this._repository);

  Future<Either<Failure, List<CartItem>>> call() async {
    return await _repository.getCartItems();
  }
}
