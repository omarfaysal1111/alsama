import 'package:alsama/features/auth/presentation/widgets/default_button.dart';
import 'package:alsama/features/cart/presentation/widgets/cart_item_widget.dart';
import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
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

      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: width*0.04, ),
        child: Column(
          children: [
            Expanded(
flex: 3,

              child: ListView.builder(
                
                itemCount: 7,
                itemBuilder: (context, index) {
                  
                  return 
                  CartItemCard(
                    quantity: 3,
                    onDecrease: () {},
                    onIncrease: () {},
                    productName: 'اسم المنتج',
                    price: ' 500',
                    size: 'M',
                    color: 'احمر فاتح',
                    image: 'assets/images/f2.png',
                  );
                },
              ),
            ),
        
        
        Container(
          decoration: BoxDecoration(
            border: BorderDirectional(
              top: BorderSide(
                color: Color(0xffF8F8F8)
              )
              ,
              
            )
          ),
          child: Padding(
            padding:  EdgeInsets.only(top:16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
            
                  children: [
                    Text('اجمالي السعر',
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      
                      color:Color(0xff55585B),
                      fontSize: 12
                    ),
                    ),
                    Text(' 2500 ج.م',
                    
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      color:Color(0xff821F40),
                      fontSize: 22,
                      fontWeight: FontWeight.w700
                    ),
                    ),
            
                  ],
                ),
            
                SizedBox(
                  width:230 ,
                  height:54 ,
                  child: DefaultButton(text: 'استمرار', onTap: (){}))
              ],
            ),
          ),
        ),
SizedBox(height: 30,)        
          ],
        ),
      ),
    );
  }
}
