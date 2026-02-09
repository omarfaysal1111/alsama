import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/cart_item.dart';

abstract class CartRepository {
  Future<Either<Failure, List<CartItem>>> getCartItems();
  Future<Either<Failure, CartItem>> addToCart(CartItem cartItem);
  Future<Either<Failure, CartItem>> updateCartItem(String cartItemId, int quantity);
  Future<Either<Failure, void>> removeFromCart(String cartItemId);
  Future<Either<Failure, void>> clearCart();
  Future<Either<Failure, int>> getCartItemsCount();
  Future<Either<Failure, double>> getCartTotal();
}

