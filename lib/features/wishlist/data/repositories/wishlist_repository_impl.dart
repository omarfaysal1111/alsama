import '../../domain/entities/wishlist_item.dart';
import '../../domain/repositories/wishlist_repository.dart';
import '../datasources/wishlist_local_data_source.dart';

class WishlistRepositoryImpl implements WishlistRepository {
  WishlistRepositoryImpl({required WishlistLocalDataSource localDataSource})
    : _localDataSource = localDataSource;

  final WishlistLocalDataSource _localDataSource;

  @override
  Future<List<WishlistItem>> getWishlistItems() {
    return _localDataSource.getWishlistItems();
  }

  @override
  Future<void> saveWishlistItems(List<WishlistItem> items) {
    return _localDataSource.cacheWishlistItems(items);
  }
}
