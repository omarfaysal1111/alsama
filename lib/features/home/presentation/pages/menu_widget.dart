import 'package:flutter/material.dart';

class MenuWidget extends StatelessWidget {
  const MenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Material(
        color: Colors.white,
        child: Container(
          width: 280,
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(height: 76),

              Text(
                'اسم المستخدم',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 12),
              Text(
                'user@gmial.com',
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12, // 🔹 حجم الخط 12px
                  color: Color(0xff55585B),
                ),
              ),

              SizedBox(height: 80),

              GestureDetector(
                onTap: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'الملف الشخصي',
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500, color: Color(0xff1C1C1C)),
                    ),
                    SizedBox(width: 16),
                    Icon(Icons.person_2_outlined, color: Color(0xff1C1C1C)),
                  ],
                ),
              ),
              SizedBox(height: 12),

              Divider(color: Color(0xffF8F8F8), thickness: 1),

              SizedBox(height: 12),

              GestureDetector(
                onTap: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      ' المفضلة',
                      
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18, color: Color(0xff1C1C1C)),
                    ),
                    SizedBox(width: 16),
                    Icon(
                      Icons.favorite_border_outlined,
                      color: Color(0xff1C1C1C),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12),

              Divider(color: Color(0xffF8F8F8), thickness: 1),

              SizedBox(height: 12),

              GestureDetector(
                onTap: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      ' السلة',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                                                fontWeight: FontWeight.w500,

                        fontSize: 18, color: Color(0xff1C1C1C)),
                    ),
                    SizedBox(width: 16),

                    SizedBox(
                      width: 24,
                      height: 24,
                      child: Image.asset('assets/images/shopping-bag.png'),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12),

              Divider(color: Color(0xffF8F8F8), thickness: 1),

              SizedBox(height: 12),
              GestureDetector(
                onTap: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'الاقسام',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                                                fontWeight: FontWeight.w500,

                        fontSize: 18, color: Color(0xff1C1C1C)),
                    ),
                    SizedBox(width: 16),
                    Icon(Icons.category_outlined, color: Color(0xff1C1C1C)),
                  ],
                ),
              ),

              SizedBox(height: 12),
              Divider(color: Color(0xffF3F3F6), thickness: 1),
              SizedBox(height: 12),

              GestureDetector(
                onTap: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'تسجيل الخروح',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                                                fontWeight: FontWeight.w500,

                        fontSize: 18,
                        color: Color.fromARGB(255, 123, 1, 1),
                      ),
                    ),
                    SizedBox(width: 16),
                    Icon(
                      Icons.logout_rounded,
                      color: Color.fromARGB(255, 123, 1, 1),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
