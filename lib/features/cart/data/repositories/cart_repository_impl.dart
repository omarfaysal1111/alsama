import 'package:dartz/dartz.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/cart_item.dart';
import '../../domain/repositories/cart_repository.dart';
import '../datasources/cart_local_datasource.dart';
import '../models/cart_item_model.dart';

class CartRepositoryImpl implements CartRepository {
  final CartLocalDataSource _localDataSource;

  const CartRepositoryImpl({
    required CartLocalDataSource localDataSource,
  }) : _localDataSource = localDataSource;

  @override
  Future<Either<Failure, List<CartItem>>> getCartItems() async {
    try {
      final cartItems = await _localDataSource.getCartItems();
      return Right(cartItems);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message, code: e.code));
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, CartItem>> addToCart(CartItem cartItem) async {
    try {
      final cartItemModel = CartItemModel.fromEntity(cartItem);
      await _localDataSource.addToCart(cartItemModel);
      return Right(cartItem);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message, code: e.code));
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, CartItem>> updateCartItem(String cartItemId, int quantity) async {
    try {
      await _localDataSource.updateCartItem(cartItemId, quantity);
      
      // Get updated cart item
      final cartItems = await _localDataSource.getCartItems();
      try {
        final updatedItem = cartItems.firstWhere((item) => item.id == cartItemId);
        return Right(updatedItem);
      } catch (e) {
        // Item was removed (quantity was 0 or less)
        return Left(CacheFailure(message: 'Cart item not found after update'));
      }
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message, code: e.code));
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> removeFromCart(String cartItemId) async {
    try {
      await _localDataSource.removeFromCart(cartItemId);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message, code: e.code));
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> clearCart() async {
    try {
      await _localDataSource.clearCart();
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message, code: e.code));
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> getCartItemsCount() async {
    try {
      final count = await _localDataSource.getCartItemsCount();
      return Right(count);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message, code: e.code));
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, double>> getCartTotal() async {
    try {
      final total = await _localDataSource.getCartTotal();
      return Right(total);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message, code: e.code));
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }
}

