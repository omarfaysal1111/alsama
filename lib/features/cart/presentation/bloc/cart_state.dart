import '../../domain/entities/cart_item.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<CartItem> cartItems;
  final int itemsCount;
  final double total;
  
  CartLoaded({
    required this.cartItems,
    required this.itemsCount,
    required this.total,
  });
}

class CartEmpty extends CartState {
  final String message;
  
  CartEmpty({required this.message});
}

class CartError extends CartState {
  final String message;
  
  CartError({required this.message});
}

class CartItemAdded extends CartState {
  final CartItem cartItem;
  
  CartItemAdded({required this.cartItem});
}

class CartItemUpdated extends CartState {
  final CartItem cartItem;
  
  CartItemUpdated({required this.cartItem});
}

class CartItemRemoved extends CartState {
  final String cartItemId;
  
  CartItemRemoved({required this.cartItemId});
}

class CartCleared extends CartState {}

class CartItemsCountLoaded extends CartState {
  final int count;
  
  CartItemsCountLoaded({required this.count});
}

class CartTotalLoaded extends CartState {
  final double total;
  
  CartTotalLoaded({required this.total});
}
