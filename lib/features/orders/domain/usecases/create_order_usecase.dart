import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/order.dart' as entities;
import '../repositories/orders_repository.dart';

class CreateOrderUseCase {
  final OrdersRepository _repository;

  const CreateOrderUseCase(this._repository);

  Future<Either<Failure, entities.Order>> call(Map<String, dynamic> orderData) async {
    return await _repository.createOrder(orderData);
  }
}
