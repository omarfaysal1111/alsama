import '../../domain/entities/order.dart' as entities;

abstract class OrdersState {}

class OrdersInitial extends OrdersState {}

class OrdersLoading extends OrdersState {}

class OrdersLoaded extends OrdersState {
  final List<entities.Order> orders;
  final bool hasReachedMax;
  final int currentPage;
  final String? currentStatus;
  
  OrdersLoaded({
    required this.orders,
    this.hasReachedMax = false,
    this.currentPage = 1,
    this.currentStatus,
  });
  
  OrdersLoaded copyWith({
    List<entities.Order>? orders,
    bool? hasReachedMax,
    int? currentPage,
    String? currentStatus,
  }) {
    return OrdersLoaded(
      orders: orders ?? this.orders,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      currentPage: currentPage ?? this.currentPage,
      currentStatus: currentStatus ?? this.currentStatus,
    );
  }
}

class OrderLoaded extends OrdersState {
  final entities.Order order;
  
  OrderLoaded({required this.order});
}

class OrderCreated extends OrdersState {
  final entities.Order order;
  
  OrderCreated({required this.order});
}

class OrderCancelled extends OrdersState {
  final entities.Order order;
  
  OrderCancelled({required this.order});
}

class OrderTracking extends OrdersState {
  final Map<String, dynamic> trackingInfo;
  
  OrderTracking({required this.trackingInfo});
}

class OrdersError extends OrdersState {
  final String message;
  
  OrdersError({required this.message});
}

class OrdersEmpty extends OrdersState {
  final String message;
  
  OrdersEmpty({required this.message});
}
