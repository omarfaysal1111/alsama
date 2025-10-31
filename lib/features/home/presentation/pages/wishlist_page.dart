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
          'السماء',
          style: TextStyle(
            fontFamily: 'Cairo',
            fontWeight: FontWeight.w500,
            color: Colors.black,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.format_align_left_outlined),
          color: Colors.black,
          iconSize: 24.0,
        ),
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
