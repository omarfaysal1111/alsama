import 'package:alsama/features/cart/presentation/widgets/cart_item_widget.dart';
import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text(
          'السلة',
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
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.black,
          iconSize: 24.0,
        ),
        
      ),

      body: Column(
        children: [


          CartItemCard(
            quantity: 3,
            onDecrease: (){},
            onIncrease: (){},
  productName: 'اسم المنتج',
  price: ' 500',
  size: 'M',
  color: 'بني',
  image: 'assets/images/img.png',
)
        ],
      ),
    );
  }
}