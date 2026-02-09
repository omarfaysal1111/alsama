import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/repositories/cart_repository.dart';

class GetCartTotalUseCase {
  final CartRepository _repository;

  const GetCartTotalUseCase(this._repository);

  Future<Either<Failure, double>> call() async {
    return await _repository.getCartTotal();
  }
}

