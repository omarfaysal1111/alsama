import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../products/domain/entities/product.dart';
import '../../domain/entities/wishlist_item.dart';
import '../../domain/repositories/wishlist_repository.dart';

class WishlistCubit extends Cubit<WishlistState> {
  WishlistCubit({required WishlistRepository repository})
    : _repository = repository,
      super(const WishlistState());

  final WishlistRepository _repository;

  Future<void> loadWishlist() async {
    emit(state.copyWith(isLoading: true, clearErrorMessage: true));
    try {
      final items = await _repository.getWishlistItems();
      emit(state.copyWith(items: items, isLoading: false));
    } catch (error) {
      emit(state.copyWith(isLoading: false, errorMessage: error.toString()));
    }
  }

  Future<void> toggleProduct(Product product) async {
    final exists = state.items.any((item) => item.id == product.id);
    final updatedItems =
        exists
            ? state.items.where((item) => item.id != product.id).toList()
            : [...state.items, WishlistItem.fromProduct(product)];

    emit(state.copyWith(items: updatedItems, clearErrorMessage: true));

    try {
      await _repository.saveWishlistItems(updatedItems);
    } catch (error) {
      emit(state.copyWith(errorMessage: error.toString()));
    }
  }

  Future<void> removeById(String productId) async {
    final exists = state.items.any((item) => item.id == productId);
    if (!exists) return;

    final updatedItems =
        state.items.where((item) => item.id != productId).toList();
    emit(state.copyWith(items: updatedItems, clearErrorMessage: true));

    try {
      await _repository.saveWishlistItems(updatedItems);
    } catch (error) {
      emit(state.copyWith(errorMessage: error.toString()));
    }
  }

  bool isFavorite(String productId) =>
      state.items.any((item) => item.id == productId);
}

class WishlistState extends Equatable {
  final List<WishlistItem> items;
  final bool isLoading;
  final String? errorMessage;

  const WishlistState({
    this.items = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  WishlistState copyWith({
    List<WishlistItem>? items,
    bool? isLoading,
    String? errorMessage,
    bool clearErrorMessage = false,
  }) {
    return WishlistState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      errorMessage:
          clearErrorMessage ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [items, isLoading, errorMessage];
}
