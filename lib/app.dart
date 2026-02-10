import 'package:alsama/features/auth/presentation/pages/login_page.dart';
import 'package:alsama/features/auth/presentation/pages/register_page.dart';
import 'package:alsama/features/cart/presentation/pages/cart_page.dart';
import 'package:alsama/features/home/presentation/pages/home_page.dart';
import 'package:alsama/features/home/presentation/pages/profile_page.dart';
import 'package:alsama/features/home/presentation/pages/wishlist_page.dart';
import 'package:alsama/features/products/presentation/pages/product_detail_page.dart';
import 'package:alsama/features/products/presentation/pages/products_page.dart';
import 'package:alsama/features/products/presentation/pages/product_detail_page.dart';
// import 'package:alsama/features/orders/presentation/pages/orders_page.dart';
import 'package:alsama/features/home/presentation/pages/wishlist_page.dart';
import 'package:alsama/features/home/presentation/pages/categories_page.dart';
import 'package:alsama/features/home/presentation/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shimmer/main.dart';
import 'core/di/injection_container.dart' as di;
import 'core/routes/app_routes.dart';
import 'features/products/presentation/bloc/products_bloc.dart';
// import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/home/presentation/bloc/home_bloc.dart';
import 'features/home/presentation/bloc/categories_bloc.dart';
import 'features/cart/presentation/bloc/cart_bloc.dart';
import 'features/cart/presentation/bloc/cart_event.dart';
import 'features/home/presentation/pages/main_page.dart';
import 'features/wishlist/presentation/cubit/wishlist_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(create: (context) => HomeBloc()),
        BlocProvider<ProductsBloc>(create: (context) => di.sl<ProductsBloc>()),
        BlocProvider<CategoriesBloc>(
          create: (context) => di.sl<CategoriesBloc>(),
        ),
        BlocProvider<CartBloc>(
          create: (context) => di.sl<CartBloc>()..add(GetCartRequested()),
        ),
        BlocProvider<WishlistCubit>(
          create: (context) => di.sl<WishlistCubit>()..loadWishlist(),
        ),
      ],
      child: MaterialApp(
        title: 'Alsama',

        theme: ThemeData(
          fontFamily: 'Cairo',
          scaffoldBackgroundColor: Colors.white,
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        home: MainPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
