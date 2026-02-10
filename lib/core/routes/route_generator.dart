import 'package:alsama/features/products/domain/entities/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/di/injection_container.dart' as di;
import '../../features/orders/presentation/bloc/orders_bloc.dart';
import '../../features/home/presentation/pages/main_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/home/presentation/pages/categories_page.dart'
    as home_categories;
import '../../features/home/presentation/pages/wishlist_page.dart';
import '../../features/home/presentation/pages/profile_page.dart';
import '../../features/products/presentation/pages/products_page.dart';
import '../../features/products/presentation/pages/product_detail_page.dart';
import '../../features/products/presentation/pages/categories_page.dart';
import '../../features/products/presentation/pages/category_products_page.dart';
import '../../features/cart/presentation/pages/cart_page.dart';
import '../../features/cart/presentation/pages/checkout_page.dart';
import '../../features/cart/presentation/pages/enhanced_checkout_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import 'app_routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // 1. Capture the arguments
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const MainPage());

      case AppRoutes.categories:
        return MaterialPageRoute(builder: (_) => const CategoriesPage());

      // --- FIX 1: Pass arguments to ProductsPage ---
      case AppRoutes.products:
        if (args is Map<String, dynamic>) {
          return MaterialPageRoute(
            builder:
                (_) => ProductsPage(
                  category: args['category'],
                  categoryLabel: args['categoryLabel'],
                ),
            settings: settings,
          );
        }
        return _errorRoute('ProductsPage requires category & categoryLabel');

      // --- FIX 2: Check type for ProductDetailPage ---
      case AppRoutes.productDetail:
        if (args is Product) {
          return MaterialPageRoute(
            builder: (_) => ProductDetailPage(product: args),
          );
        }
        return _errorRoute('ProductDetailPage requires a "Product" object');

      case '/category-products':
        if (args is Map<String, dynamic>) {
          return MaterialPageRoute(
            builder:
                (_) => CategoryProductsPage(
                  categoryId: args['categoryId'] as int,
                  categoryName: args['categoryName'] as String,
                ),
          );
        }
        return _errorRoute(
          'CategoryProductsPage requires categoryId & categoryName',
        );

      case AppRoutes.cart:
        return MaterialPageRoute(builder: (_) => const CartPage());

      case AppRoutes.checkout:
        return MaterialPageRoute(builder: (_) => const CheckoutPage());

      case '/enhanced-checkout':
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (_) => di.sl<OrdersBloc>(),
                child: const EnhancedCheckoutPage(),
              ),
        );

      case AppRoutes.wishlist:
        return MaterialPageRoute(builder: (_) => const WishlistPage());

      case AppRoutes.profile:
        return MaterialPageRoute(builder: (_) => const ProfilePage());

      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginPage());

      case AppRoutes.register:
        return MaterialPageRoute(builder: (_) => const RegisterPage());

      default:
        return _errorRoute('No route defined for ${settings.name}');
    }
  }

  static Route<dynamic> _errorRoute(String message) {
    return MaterialPageRoute(
      builder:
          (_) => Scaffold(
            appBar: AppBar(
              title: const Text('Error'),
              backgroundColor: Colors.red,
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 80,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      message,
                      style: const TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        // Navigate back or to home
                      },
                      child: const Text('Go Back'),
                    ),
                  ],
                ),
              ),
            ),
          ),
    );
  }
}
