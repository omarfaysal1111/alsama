import 'package:alsama/features/auth/presentation/pages/login_page.dart';
import 'package:alsama/features/auth/presentation/pages/register_page.dart';
import 'package:alsama/features/cart/presentation/pages/cart_page.dart';
import 'package:alsama/features/home/presentation/pages/home_page.dart';
import 'package:alsama/features/home/presentation/pages/profile_page.dart';
import 'package:alsama/features/home/presentation/pages/wishlist_page.dart';
import 'package:alsama/features/products/presentation/pages/product_detail_page.dart';
import 'package:alsama/features/products/presentation/pages/products_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/di/injection_container.dart' as di;
import 'features/products/presentation/bloc/products_bloc.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/home/presentation/bloc/home_bloc.dart';
import 'features/home/presentation/pages/main_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(create: (context) => HomeBloc()),
        BlocProvider<ProductsBloc>(create: (context) => di.sl<ProductsBloc>()),
      ],
      child: MaterialApp(
        
        title: 'Alsama',
       
      
        theme: ThemeData(

          
          fontFamily: 'Cairo', 
          scaffoldBackgroundColor: Colors.white,
          primarySwatch: Colors.blue, useMaterial3: true),
        home:  MainPage(),
        debugShowCheckedModeBanner: false,
      ),



      
    );
  }
}
