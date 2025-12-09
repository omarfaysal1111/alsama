import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';
import 'home_page.dart';
import 'categories_page.dart';
import 'wishlist_page.dart';
import 'profile_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
    print('MainPage: initState called');
    context.read<HomeBloc>().add(HomeInitialized());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeInitial) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        
        if (state is HomeLoaded) {
          return Scaffold(
  body: _getPage(state.currentIndex),
  bottomNavigationBar: Container(
    decoration: BoxDecoration(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          blurRadius: 10,
          offset: const Offset(0, -2),
        ),
      ],
    ),
    child: ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        
        currentIndex: state.currentIndex,
        onTap: (index) {
          context.read<HomeBloc>().add(TabChanged(index: index));
        },
        backgroundColor: Colors.white,
        selectedItemColor: Color(0xff821F40),
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 12,
        ),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'الرئيسية',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category_outlined),
            activeIcon: Icon(Icons.category),
            label: 'الاقسام',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            activeIcon: Icon(Icons.favorite),
            label: 'المفضلة',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.shopping_cart_outlined),
          //   activeIcon: Icon(Icons.shopping_cart),
          //   label: 'السله',
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'الحساب',
          ),
        ],
      ),
    ),
  ),
);
        }
        
        return const Scaffold(
          body: Center(child: Text('Something went wrong')),
        );
      },
    );
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return const HomePage();
      case 1:
        return const CategoriesPage();
      case 2:
        return const WishlistPage();
      case 3:
        return const ProfilePage();
      // case 4:
      //   return const CartPage();
      default:
        return const HomePage();
    }
  }
}
