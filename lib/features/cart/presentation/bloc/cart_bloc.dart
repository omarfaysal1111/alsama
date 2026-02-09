import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/add_to_cart_usecase.dart';
import '../../domain/usecases/get_cart_usecase.dart';
import '../../domain/usecases/update_cart_item_usecase.dart';
import '../../domain/usecases/remove_from_cart_usecase.dart';
import '../../domain/usecases/clear_cart_usecase.dart';
import '../../domain/usecases/get_cart_items_count_usecase.dart';
import '../../domain/usecases/get_cart_total_usecase.dart';
import '../../domain/entities/cart_item.dart';
// import '../../../products/domain/entities/product.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final AddToCartUseCase _addToCartUseCase;
  final GetCartUseCase _getCartUseCase;
  final UpdateCartItemUseCase _updateCartItemUseCase;
  final RemoveFromCartUseCase _removeFromCartUseCase;
  final ClearCartUseCase _clearCartUseCase;
  final GetCartItemsCountUseCase _getCartItemsCountUseCase;
  final GetCartTotalUseCase _getCartTotalUseCase;

  CartBloc({
    required AddToCartUseCase addToCartUseCase,
    required GetCartUseCase getCartUseCase,
    required UpdateCartItemUseCase updateCartItemUseCase,
    required RemoveFromCartUseCase removeFromCartUseCase,
    required ClearCartUseCase clearCartUseCase,
    required GetCartItemsCountUseCase getCartItemsCountUseCase,
    required GetCartTotalUseCase getCartTotalUseCase,
  }) : _addToCartUseCase = addToCartUseCase,
       _getCartUseCase = getCartUseCase,
       _updateCartItemUseCase = updateCartItemUseCase,
       _removeFromCartUseCase = removeFromCartUseCase,
       _clearCartUseCase = clearCartUseCase,
       _getCartItemsCountUseCase = getCartItemsCountUseCase,
       _getCartTotalUseCase = getCartTotalUseCase,
       super(CartInitial()) {
    on<GetCartRequested>(_onGetCartRequested);
    on<AddToCartRequested>(_onAddToCartRequested);
    on<AddProductToCartRequested>(_onAddProductToCartRequested);
    on<UpdateCartItemQuantityRequested>(_onUpdateCartItemQuantityRequested);
    on<RemoveFromCartRequested>(_onRemoveFromCartRequested);
    on<ClearCartRequested>(_onClearCartRequested);
    on<GetCartItemsCountRequested>(_onGetCartItemsCountRequested);
    on<GetCartTotalRequested>(_onGetCartTotalRequested);
    on<RefreshCartRequested>(_onRefreshCartRequested);
  }

  Future<void> _onGetCartRequested(
    GetCartRequested event,
    Emitter<CartState> emit,
  ) async {
    emit(CartLoading());

    final result = await _getCartUseCase();

    result.fold((failure) => emit(CartError(message: failure.message)), (
      cartItems,
    ) {
      if (cartItems.isEmpty) {
        emit(CartEmpty(message: 'Your cart is empty'));
      } else {
        final total = cartItems.fold<double>(
          0.0,
          (double sum, item) => sum + item.totalPrice,
        );
        final itemsCount = cartItems.fold<int>(
          0,
          (int sum, item) => sum + item.quantity,
        );
        emit(
          CartLoaded(
            cartItems: cartItems,
            itemsCount: itemsCount,
            total: total,
          ),
        );
      }
    });
  }

  Future<void> _onAddToCartRequested(
    AddToCartRequested event,
    Emitter<CartState> emit,
  ) async {
    // We need to get the product first, but for now we'll create a cart item
    // The product should be passed in the event
    // For now, we'll emit loading and then handle it in the UI
    emit(CartLoading());

    // This will be handled by getting the product and creating a cart item
    // For now, we'll just refresh the cart
    add(GetCartRequested());
  }

  Future<void> _onAddProductToCartRequested(
    AddProductToCartRequested event,
    Emitter<CartState> emit,
  ) async {
    emit(CartLoading());

    final cartItem = CartItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      product: event.product,
      quantity: event.quantity,
      addedAt: DateTime.now(),
    );

    final result = await _addToCartUseCase(cartItem);

    result.fold((failure) => emit(CartError(message: failure.message)), (item) {
      emit(CartItemAdded(cartItem: item));
      add(GetCartRequested());
    });
  }

  Future<void> _onUpdateCartItemQuantityRequested(
    UpdateCartItemQuantityRequested event,
    Emitter<CartState> emit,
  ) async {
    final result = await _updateCartItemUseCase(
      event.cartItemId,
      event.quantity,
    );

    result.fold((failure) => emit(CartError(message: failure.message)), (
      cartItem,
    ) {
      emit(CartItemUpdated(cartItem: cartItem));
      add(GetCartRequested());
    });
  }

  Future<void> _onRemoveFromCartRequested(
    RemoveFromCartRequested event,
    Emitter<CartState> emit,
  ) async {
    final result = await _removeFromCartUseCase(event.cartItemId);

    result.fold((failure) => emit(CartError(message: failure.message)), (_) {
      emit(CartItemRemoved(cartItemId: event.cartItemId));
      add(GetCartRequested());
    });
  }

  Future<void> _onClearCartRequested(
    ClearCartRequested event,
    Emitter<CartState> emit,
  ) async {
    final result = await _clearCartUseCase();

    result.fold((failure) => emit(CartError(message: failure.message)), (_) {
      emit(CartCleared());
      emit(CartEmpty(message: 'Your cart is empty'));
    });
  }

  Future<void> _onGetCartItemsCountRequested(
    GetCartItemsCountRequested event,
    Emitter<CartState> emit,
  ) async {
    final result = await _getCartItemsCountUseCase();

    result.fold(
      (failure) => emit(CartError(message: failure.message)),
      (count) => emit(CartItemsCountLoaded(count: count)),
    );
  }

  Future<void> _onGetCartTotalRequested(
    GetCartTotalRequested event,
    Emitter<CartState> emit,
  ) async {
    final result = await _getCartTotalUseCase();

    result.fold(
      (failure) => emit(CartError(message: failure.message)),
      (total) => emit(CartTotalLoaded(total: total)),
    );
  }

  Future<void> _onRefreshCartRequested(
    RefreshCartRequested event,
    Emitter<CartState> emit,
  ) async {
    add(GetCartRequested());
  }
}
