import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/order.dart' as entities;

abstract class OrdersRepository {
  Future<Either<Failure, List<entities.Order>>> getOrders();
  Future<Either<Failure, entities.Order>> getOrderById(String orderId);
  Future<Either<Failure, entities.Order>> createOrder(Map<String, dynamic> orderData);
  Future<Either<Failure, entities.Order>> cancelOrder(String orderId);
  Future<Either<Failure, Map<String, dynamic>>> trackOrder(String orderId);
}
