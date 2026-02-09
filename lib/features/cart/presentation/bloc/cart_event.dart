import '../../../products/domain/entities/product.dart';

abstract class CartEvent {}

class GetCartRequested extends CartEvent {}

class AddToCartRequested extends CartEvent {
  final String productId;
  final int quantity;
  
  AddToCartRequested({
    required this.productId,
    required this.quantity,
  });
}

class AddProductToCartRequested extends CartEvent {
  final Product product;
  final int quantity;
  
  AddProductToCartRequested({
    required this.product,
    required this.quantity,
  });
}

class UpdateCartItemQuantityRequested extends CartEvent {
  final String cartItemId;
  final int quantity;
  
  UpdateCartItemQuantityRequested({
    required this.cartItemId,
    required this.quantity,
  });
}

class RemoveFromCartRequested extends CartEvent {
  final String cartItemId;
  
  RemoveFromCartRequested({required this.cartItemId});
}

class ClearCartRequested extends CartEvent {}

class GetCartItemsCountRequested extends CartEvent {}

class GetCartTotalRequested extends CartEvent {}

class RefreshCartRequested extends CartEvent {}

class ApplyCouponRequested extends CartEvent {
  final String couponCode;
  
  ApplyCouponRequested({required this.couponCode});
}

class RemoveCouponRequested extends CartEvent {}

class UpdateShippingMethodRequested extends CartEvent {
  final String shippingMethodId;
  
  UpdateShippingMethodRequested({required this.shippingMethodId});
}
