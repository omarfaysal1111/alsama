import 'package:flutter/material.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('الأقسام',style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Colors.black
        ),),
        leading: IconButton(onPressed: (){}, icon:Icon(Icons.format_align_left),color: Colors.black,),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.shopping_bag_outlined),color: Colors.black,iconSize: 24,)
        ],
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
     body: Padding(
  padding: EdgeInsets.symmetric(horizontal: width * 0.04),
  child: Column(
    children: [
      Expanded( 
        child: ListView.builder(
          itemCount: 3,
          padding: EdgeInsets.all(0),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: (){},
              child: Container(  
                margin: EdgeInsets.only(bottom: height*0.016),
                height: height*100/844,
                decoration: BoxDecoration(
                  color: Color(0xffF3F5F6),
                  borderRadius: BorderRadius.circular(0),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: width*0.04),
                        child: Text(
                          'اسدال',  
                                                      textAlign: TextAlign.right,
                 
                          textDirection: TextDirection.rtl,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
              
                    ClipRRect(
                      child: Image.asset(
                        'assets/images/img.png',
                        width: 80,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    ],
  ),
),
    );
  }}