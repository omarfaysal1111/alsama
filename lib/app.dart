import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/di/injection_container.dart' as di;
import 'core/routes/app_routes.dart';
import 'core/routes/route_generator.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/bloc/auth_event.dart';
import 'features/products/presentation/bloc/products_bloc.dart';
import 'features/home/presentation/bloc/home_bloc.dart';
import 'features/home/presentation/bloc/categories_bloc.dart';
import 'features/cart/presentation/bloc/cart_bloc.dart';
import 'features/cart/presentation/bloc/cart_event.dart';
import 'features/wishlist/presentation/cubit/wishlist_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => di.sl<AuthBloc>()..add(GetCurrentUserRequested()),
        ),
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
        initialRoute: AppRoutes.login,
        onGenerateRoute: RouteGenerator.generateRoute,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
