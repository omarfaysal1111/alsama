import 'package:alsama/features/home/presentation/pages/menu_widget.dart';
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
        ],
        centerTitle: true,
         surfaceTintColor: Colors.white,
        foregroundColor: Colors.white,
        backgroundColor: Colors.white,
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