import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:injectable/injectable.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../network/network_info.dart';
// import '../../features/auth/data/datasources/auth_remote_datasource.dart';
// import '../../features/auth/data/datasources/auth_local_datasource.dart';
// import '../../features/auth/data/repositories/auth_repository_impl.dart';
// import '../../features/auth/domain/repositories/auth_repository.dart';
// import '../../features/auth/domain/usecases/login_usecase.dart';
// import '../../features/auth/domain/usecases/register_usecase.dart';
// import '../../features/auth/domain/usecases/logout_usecase.dart';
// import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/products/data/datasources/products_remote_datasource.dart';
import '../../features/products/data/repositories/products_repository_impl.dart';
import '../../features/products/domain/repositories/products_repository.dart';
import '../../features/products/domain/usecases/get_products_usecase.dart';
import '../../features/products/domain/usecases/get_product_by_id_usecase.dart';
import '../../features/products/domain/usecases/search_products_usecase.dart';
import '../../features/products/domain/usecases/get_categories_usecase.dart'
    as products;
import '../../features/products/domain/usecases/get_models_by_category_usecase.dart';
import '../../features/products/presentation/bloc/products_bloc.dart';
import '../../features/home/data/datasources/categories_remote_datasource.dart';
import '../../features/home/data/repositories/categories_repository_impl.dart';
import '../../features/home/domain/repositories/categories_repository.dart';
import '../../features/home/domain/usecases/get_categories_usecase.dart'
    as home;
import '../../features/home/presentation/bloc/categories_bloc.dart';
import '../../features/cart/data/datasources/cart_local_datasource.dart';
import '../../features/cart/data/repositories/cart_repository_impl.dart';
import '../../features/cart/domain/repositories/cart_repository.dart';
import '../../features/cart/domain/usecases/add_to_cart_usecase.dart';
import '../../features/cart/domain/usecases/get_cart_usecase.dart';
import '../../features/cart/domain/usecases/update_cart_item_usecase.dart';
import '../../features/cart/domain/usecases/remove_from_cart_usecase.dart';
import '../../features/cart/domain/usecases/clear_cart_usecase.dart';
import '../../features/cart/domain/usecases/get_cart_items_count_usecase.dart';
import '../../features/cart/domain/usecases/get_cart_total_usecase.dart';
import '../../features/cart/presentation/bloc/cart_bloc.dart';
import '../../features/wishlist/data/datasources/wishlist_local_data_source.dart';
import '../../features/wishlist/data/repositories/wishlist_repository_impl.dart';
import '../../features/wishlist/domain/repositories/wishlist_repository.dart';
import '../../features/wishlist/presentation/cubit/wishlist_cubit.dart';

final sl = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async {
  // External dependencies
  sl.registerLazySingleton(() => Dio());
  // SharedPreferences needs to be awaited before registration
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  sl.registerLazySingleton(() => Connectivity());

  // Core
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(connectivity: sl()),
  );

  // Data sources
  sl.registerLazySingleton<ProductsRemoteDataSource>(
    () => ProductsRemoteDataSourceImpl(dio: sl()),
  );
  sl.registerLazySingleton<CategoriesRemoteDataSource>(
    () => CategoriesRemoteDataSourceImpl(dio: sl()),
  );
  sl.registerLazySingleton<CartLocalDataSource>(
    () => CartLocalDataSourceImpl(sharedPreferences: sl()),
  );
  sl.registerLazySingleton<WishlistLocalDataSource>(
    () => WishlistLocalDataSourceImpl(sharedPreferences: sl()),
  );

  // Repositories
  sl.registerLazySingleton<ProductsRepository>(
    () => ProductsRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()),
  );
  sl.registerLazySingleton<CategoriesRepository>(
    () => CategoriesRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()),
  );
  sl.registerLazySingleton<CartRepository>(
    () => CartRepositoryImpl(localDataSource: sl()),
  );
  sl.registerLazySingleton<WishlistRepository>(
    () => WishlistRepositoryImpl(localDataSource: sl()),
  );

  // Use cases

  sl.registerLazySingleton(() => GetProductsUseCase(sl()));
  sl.registerLazySingleton(() => GetProductByIdUseCase(sl()));
  sl.registerLazySingleton(() => SearchProductsUseCase(sl()));
  sl.registerLazySingleton(() => products.GetCategoriesUseCase(sl()));
  sl.registerLazySingleton(() => GetModelsByCategoryUseCase(sl()));
  sl.registerLazySingleton(() => home.GetCategoriesUseCase(sl()));
  sl.registerLazySingleton(() => AddToCartUseCase(sl()));
  sl.registerLazySingleton(() => GetCartUseCase(sl()));
  sl.registerLazySingleton(() => UpdateCartItemUseCase(sl()));
  sl.registerLazySingleton(() => RemoveFromCartUseCase(sl()));
  sl.registerLazySingleton(() => ClearCartUseCase(sl()));
  sl.registerLazySingleton(() => GetCartItemsCountUseCase(sl()));
  sl.registerLazySingleton(() => GetCartTotalUseCase(sl()));

  // BLoCs

  sl.registerFactory(
    () => ProductsBloc(
      getProductsUseCase: sl(),
      getProductByIdUseCase: sl(),
      searchProductsUseCase: sl(),
      getCategoriesUseCase: sl<products.GetCategoriesUseCase>(),
      getModelsByCategoryUseCase: sl(),
    ),
  );
  sl.registerFactory(
    () => CategoriesBloc(getCategoriesUseCase: sl<home.GetCategoriesUseCase>()),
  );
  sl.registerFactory(
    () => CartBloc(
      addToCartUseCase: sl(),
      getCartUseCase: sl(),
      updateCartItemUseCase: sl(),
      removeFromCartUseCase: sl(),
      clearCartUseCase: sl(),
      getCartItemsCountUseCase: sl(),
      getCartTotalUseCase: sl(),
    ),
  );
  sl.registerFactory(() => WishlistCubit(repository: sl()));
}
