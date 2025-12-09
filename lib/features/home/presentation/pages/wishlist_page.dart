import 'package:alsama/features/home/presentation/pages/menu_widget.dart';
import 'package:flutter/material.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {

        double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'المفضلة',
          style: TextStyle(
            fontFamily: 'Cairo',
            fontWeight: FontWeight.w500,
            color: Colors.black,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
         surfaceTintColor: Colors.white,
        foregroundColor: Colors.white,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(onPressed: (){

    showGeneralDialog(
  context: context,
  barrierDismissible: true,
  barrierLabel: "إغلاق",
  barrierColor: Colors.black.withOpacity(0.3),
  pageBuilder: (context, animation, secondaryAnimation) {
    return Align(
      alignment: Alignment.centerLeft, 
      child: MenuWidget(),
    );
  },
  transitionBuilder: (context, animation, secondaryAnimation, child) {
    final offsetAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0), 
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
      ),
    );

    return SlideTransition(
      position: offsetAnimation,
      child: child,
    );
  },



          
          
          );
        }, icon:Icon(Icons.format_align_left),color: Colors.black,),
        actions: [
          GestureDetector(
            onTap: (){},
            child: Padding(
              padding:  EdgeInsets.only(right: width*(16.0/390)),
              child: SizedBox(
                width: 24,
                height: 24,
                child: Image.asset('assets/images/shopping-bag.png')),
            ),
          ),
          // IconButton(
          //   icon: const Icon(Icons.refresh, color: Colors.black),
          //   onPressed: () {
          //     print('HomePage: Manual refresh triggered');
          //     context.read<ProductsBloc>().add(GetProductsRequested());
          //   },
          // ),
        ],
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite_border,
              size: 64,
              color: Colors.grey,
            ),
            SizedBox(height: 16),
            Text(
              'Your Wishlist',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'No items in wishlist yet',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
