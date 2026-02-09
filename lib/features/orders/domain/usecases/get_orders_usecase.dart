import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/order.dart' as entities;
import '../repositories/orders_repository.dart';

class GetOrdersUseCase {
  final OrdersRepository _repository;

  const GetOrdersUseCase(this._repository);

  Future<Either<Failure, List<entities.Order>>> call() async {
    return await _repository.getOrders();
  }
}
