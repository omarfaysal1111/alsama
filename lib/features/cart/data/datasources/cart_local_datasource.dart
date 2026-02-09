import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/cart_item_model.dart';

abstract class CartLocalDataSource {
  Future<List<CartItemModel>> getCartItems();
  Future<void> addToCart(CartItemModel cartItem);
  Future<void> updateCartItem(String cartItemId, int quantity);
  Future<void> removeFromCart(String cartItemId);
  Future<void> clearCart();
  Future<int> getCartItemsCount();
  Future<double> getCartTotal();
}

class CartLocalDataSourceImpl implements CartLocalDataSource {
  final SharedPreferences _sharedPreferences;

  CartLocalDataSourceImpl({required SharedPreferences sharedPreferences})
    : _sharedPreferences = sharedPreferences;

  @override
  Future<List<CartItemModel>> getCartItems() async {
    try {
      final cartDataJson = _sharedPreferences.getString(
        AppConstants.cartDataKey,
      );
      if (cartDataJson == null || cartDataJson.isEmpty) {
        return [];
      }

      final List<dynamic> cartData = json.decode(cartDataJson);
      return CartItemModel.fromJsonList(cartData);
    } catch (e) {
      throw CacheException(
        message: 'Failed to get cart items: ${e.toString()}',
      );
    }
  }

  @override
  Future<void> addToCart(CartItemModel cartItem) async {
    try {
      final cartItems = await getCartItems();

      // Check if product already exists in cart
      final existingItemIndex = cartItems.indexWhere(
        (item) => item.product.id == cartItem.product.id,
      );

      if (existingItemIndex != -1) {
        // Update quantity if product already exists
        final existingItem = cartItems[existingItemIndex];
        cartItems[existingItemIndex] = CartItemModel(
          id: existingItem.id,
          product: existingItem.product,
          quantity: existingItem.quantity + cartItem.quantity,
          addedAt: existingItem.addedAt,
        );
      } else {
        // Add new item to cart
        cartItems.add(cartItem);
      }

      await _saveCartItems(cartItems);
    } catch (e) {
      throw CacheException(message: 'Failed to add to cart: ${e.toString()}');
    }
  }

  @override
  Future<void> updateCartItem(String cartItemId, int quantity) async {
    try {
      final cartItems = await getCartItems();
      final itemIndex = cartItems.indexWhere((item) => item.id == cartItemId);

      if (itemIndex == -1) {
        throw CacheException(message: 'Cart item not found');
      }

      if (quantity <= 0) {
        // Remove item if quantity is 0 or less
        cartItems.removeAt(itemIndex);
      } else {
        // Update quantity
        final existingItem = cartItems[itemIndex];
        cartItems[itemIndex] = CartItemModel(
          id: existingItem.id,
          product: existingItem.product,
          quantity: quantity,
          addedAt: existingItem.addedAt,
        );
      }

      await _saveCartItems(cartItems);
    } catch (e) {
      throw CacheException(
        message: 'Failed to update cart item: ${e.toString()}',
      );
    }
  }

  @override
  Future<void> removeFromCart(String cartItemId) async {
    try {
      final cartItems = await getCartItems();
      cartItems.removeWhere((item) => item.id == cartItemId);
      await _saveCartItems(cartItems);
    } catch (e) {
      throw CacheException(
        message: 'Failed to remove from cart: ${e.toString()}',
      );
    }
  }

  @override
  Future<void> clearCart() async {
    try {
      await _sharedPreferences.remove(AppConstants.cartDataKey);
    } catch (e) {
      throw CacheException(message: 'Failed to clear cart: ${e.toString()}');
    }
  }

  @override
  Future<int> getCartItemsCount() async {
    try {
      final cartItems = await getCartItems();
      return cartItems.fold<int>(0, (int sum, item) => sum + item.quantity);
    } catch (e) {
      throw CacheException(
        message: 'Failed to get cart items count: ${e.toString()}',
      );
    }
  }

  @override
  Future<double> getCartTotal() async {
    try {
      final cartItems = await getCartItems();
      return cartItems.fold<double>(
        0.0,
        (double sum, item) => sum + item.totalPrice,
      );
    } catch (e) {
      throw CacheException(
        message: 'Failed to get cart total: ${e.toString()}',
      );
    }
  }

  Future<void> _saveCartItems(List<CartItemModel> cartItems) async {
    final cartDataJson = json.encode(CartItemModel.toJsonList(cartItems));
    await _sharedPreferences.setString(AppConstants.cartDataKey, cartDataJson);
  }
}
