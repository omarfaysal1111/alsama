import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/create_order_usecase.dart';
import '../../domain/usecases/get_orders_usecase.dart';
import '../../domain/usecases/get_order_by_id_usecase.dart';
import '../../domain/usecases/cancel_order_usecase.dart';
import 'orders_event.dart';
import 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final GetOrdersUseCase _getOrdersUseCase;
  final GetOrderByIdUseCase _getOrderByIdUseCase;
  final CreateOrderUseCase _createOrderUseCase;
  final CancelOrderUseCase _cancelOrderUseCase;
  
  OrdersBloc({
    required GetOrdersUseCase getOrdersUseCase,
    required GetOrderByIdUseCase getOrderByIdUseCase,
    required CreateOrderUseCase createOrderUseCase,
    required CancelOrderUseCase cancelOrderUseCase,
  }) : _getOrdersUseCase = getOrdersUseCase,
       _getOrderByIdUseCase = getOrderByIdUseCase,
       _createOrderUseCase = createOrderUseCase,
       _cancelOrderUseCase = cancelOrderUseCase,
       super(OrdersInitial()) {
    
    on<GetOrdersRequested>(_onGetOrdersRequested);
    on<GetOrderByIdRequested>(_onGetOrderByIdRequested);
    on<CreateOrderRequested>(_onCreateOrderRequested);
    on<CancelOrderRequested>(_onCancelOrderRequested);
    on<RefreshOrdersRequested>(_onRefreshOrdersRequested);
    on<LoadMoreOrdersRequested>(_onLoadMoreOrdersRequested);
    on<FilterOrdersRequested>(_onFilterOrdersRequested);
  }
  
  Future<void> _onGetOrdersRequested(
    GetOrdersRequested event,
    Emitter<OrdersState> emit,
  ) async {
    emit(OrdersLoading());
    
    final result = await _getOrdersUseCase();
    
    result.fold(
      (failure) => emit(OrdersError(message: failure.message)),
      (orders) {
        if (orders.isEmpty) {
          emit(OrdersEmpty(message: 'لا توجد طلبات'));
        } else {
          // Apply status filter if provided
          List<dynamic> filteredOrders = orders;
          if (event.status != null && event.status!.isNotEmpty) {
            filteredOrders = orders.where((order) {
              return order.status.toString().split('.').last == event.status;
            }).toList();
          }
          
          emit(OrdersLoaded(
            orders: filteredOrders.cast(),
            currentPage: event.page,
            currentStatus: event.status,
          ));
        }
      },
    );
  }
  
  Future<void> _onGetOrderByIdRequested(
    GetOrderByIdRequested event,
    Emitter<OrdersState> emit,
  ) async {
    emit(OrdersLoading());
    
    final result = await _getOrderByIdUseCase(event.orderId);
    
    result.fold(
      (failure) => emit(OrdersError(message: failure.message)),
      (order) => emit(OrderLoaded(order: order)),
    );
  }
  
  Future<void> _onCreateOrderRequested(
    CreateOrderRequested event,
    Emitter<OrdersState> emit,
  ) async {
    emit(OrdersLoading());
    
    final result = await _createOrderUseCase(event.orderData);
    
    result.fold(
      (failure) => emit(OrdersError(message: failure.message)),
      (order) => emit(OrderCreated(order: order)),
    );
  }
  
  Future<void> _onCancelOrderRequested(
    CancelOrderRequested event,
    Emitter<OrdersState> emit,
  ) async {
    emit(OrdersLoading());
    
    final result = await _cancelOrderUseCase(event.orderId);
    
    result.fold(
      (failure) => emit(OrdersError(message: failure.message)),
      (order) => emit(OrderCancelled(order: order)),
    );
  }
  
  Future<void> _onRefreshOrdersRequested(
    RefreshOrdersRequested event,
    Emitter<OrdersState> emit,
  ) async {
    add(GetOrdersRequested());
  }
  
  Future<void> _onLoadMoreOrdersRequested(
    LoadMoreOrdersRequested event,
    Emitter<OrdersState> emit,
  ) async {
    final currentState = state;
    if (currentState is OrdersLoaded && !currentState.hasReachedMax) {
      add(GetOrdersRequested(
        page: currentState.currentPage + 1,
        status: currentState.currentStatus,
      ));
    }
  }
  
  Future<void> _onFilterOrdersRequested(
    FilterOrdersRequested event,
    Emitter<OrdersState> emit,
  ) async {
    add(GetOrdersRequested(status: event.status));
  }
}
