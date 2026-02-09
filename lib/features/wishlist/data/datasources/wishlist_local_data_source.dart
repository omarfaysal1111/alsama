import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/wishlist_item.dart';

abstract class WishlistLocalDataSource {
  Future<List<WishlistItem>> getWishlistItems();
  Future<void> cacheWishlistItems(List<WishlistItem> items);
}

const String _wishlistPrefsKey = 'wishlist_items';

class WishlistLocalDataSourceImpl implements WishlistLocalDataSource {
  WishlistLocalDataSourceImpl({required SharedPreferences sharedPreferences})
    : _sharedPreferences = sharedPreferences;

  final SharedPreferences _sharedPreferences;

  @override
  Future<List<WishlistItem>> getWishlistItems() async {
    final cachedList = _sharedPreferences.getStringList(_wishlistPrefsKey);
    if (cachedList == null) return [];

    return cachedList
        .map(
          (item) =>
              WishlistItem.fromJson(json.decode(item) as Map<String, dynamic>),
        )
        .toList();
  }

  @override
  Future<void> cacheWishlistItems(List<WishlistItem> items) async {
    final encodedItems =
        items.map((item) => json.encode(item.toJson())).toList();
    await _sharedPreferences.setStringList(_wishlistPrefsKey, encodedItems);
  }
}
