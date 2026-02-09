abstract class OrdersEvent {}

class GetOrdersRequested extends OrdersEvent {
  final int page;
  final int limit;
  final String? status;
  
  GetOrdersRequested({
    this.page = 1,
    this.limit = 20,
    this.status,
  });
}

class GetOrderByIdRequested extends OrdersEvent {
  final String orderId;
  
  GetOrderByIdRequested({required this.orderId});
}

class CreateOrderRequested extends OrdersEvent {
  final Map<String, dynamic> orderData;
  
  CreateOrderRequested({required this.orderData});
}

class CancelOrderRequested extends OrdersEvent {
  final String orderId;
  final String? reason;
  
  CancelOrderRequested({
    required this.orderId,
    this.reason,
  });
}

class UpdateOrderStatusRequested extends OrdersEvent {
  final String orderId;
  final String status;
  final String? trackingNumber;
  
  UpdateOrderStatusRequested({
    required this.orderId,
    required this.status,
    this.trackingNumber,
  });
}

class RefreshOrdersRequested extends OrdersEvent {}

class LoadMoreOrdersRequested extends OrdersEvent {}

class FilterOrdersRequested extends OrdersEvent {
  final String? status;
  final DateTime? startDate;
  final DateTime? endDate;
  
  FilterOrdersRequested({
    this.status,
    this.startDate,
    this.endDate,
  });
}

class TrackOrderRequested extends OrdersEvent {
  final String orderId;
  
  TrackOrderRequested({required this.orderId});
}

class ReorderRequested extends OrdersEvent {
  final String orderId;
  
  ReorderRequested({required this.orderId});
}
