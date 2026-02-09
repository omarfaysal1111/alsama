import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/order.dart' as entities;
import '../repositories/orders_repository.dart';

class GetOrderByIdUseCase {
  final OrdersRepository _repository;

  const GetOrderByIdUseCase(this._repository);

  Future<Either<Failure, entities.Order>> call(String orderId) async {
    return await _repository.getOrderById(orderId);
  }
}
