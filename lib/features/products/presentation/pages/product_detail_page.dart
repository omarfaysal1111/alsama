import 'package:flutter/material.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Icon(Icons.arrow_back_ios,color: Colors.black,),
      ),

      body: Column(
        children: [
          Container(
            width:double.infinity ,
            height: height*(400/844),
            decoration: BoxDecoration(color: Color(0xffF3F5F6)),
            child: Image.asset('assets/images/bigimg.png'),
          ),


          Padding(

            padding:  EdgeInsets.symmetric(horizontal: width*(16/390),vertical: height*(16/844)),
            child: Row(
              
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              
                Text('500 ح.م'),

                Text(
                  textAlign: TextAlign.right,
                  'اسم المنتج',

                  
                  style: TextStyle(
                    fontSize: 16
,color: Colors.black,
fontWeight: FontWeight.w500
                ),)
            ,            ],
            ),
          )
        ],
      ),
    );
  }
}