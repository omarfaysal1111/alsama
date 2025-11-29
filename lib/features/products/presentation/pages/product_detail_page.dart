import 'package:alsama/features/auth/presentation/widgets/default_button.dart';
import 'package:alsama/features/products/presentation/widgets/custom_dropdown.dart';
import 'package:flutter/material.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    String? selectedSize;
    String? selectedColor;
    final List<String> size = ['S', 'XL', 'L', 'M'];
    final List<String> color = ['red', 'blue', 'black', 'white'];

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        foregroundColor: Colors.white,
        backgroundColor: Colors.white,
        elevation: 0,
        shadowColor: Colors.white,
        leading: Icon(Icons.arrow_back_ios, color: Colors.black),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: height * (16 / 844)),
              child: Container(
                width: double.infinity,
                height: height * (400 / 844),
                decoration: BoxDecoration(color: Color(0xffF3F5F6)),
                child: Image.asset('assets/images/bigimg.png'),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * (16 / 390)),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\u202B 500 جنيه', //    \u202B قبل text
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          color: Color(0xff821F40),
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      Text(
                        textAlign: TextAlign.right,
                        'اسم المنتج',

                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height * (16 / 844)),
                  Divider(color: Color(0xffF8F8F8), thickness: 1),

                  SizedBox(height: height * (12 / 844)),

                  SizedBox(
                    height: height * (80 / 844),

                    child: Directionality(
                      textDirection: TextDirection.rtl,

                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,

                        itemCount: 16,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(
                              left: width * (16 / 390),
                              bottom: height * (16 / 844),
                            ),
                            child: Container(
                              width: width * (60 / 390),
                              decoration: BoxDecoration(
                                color: const Color(0xffF3F5F6),
                              ),
                              child: SizedBox(
                                width: width * (60 / 390),
                                height: height * (80 / 844),
                                child: Image.asset('assets/images/f2.png'),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Divider(color: Color(0xffF8F8F8), thickness: 1),

                  SizedBox(height: height * (16 / 844)),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.only(right: width * (16 / 390)),
              child: Text(
                'وصف المنتج',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(
                right: width * (16 / 390),
                top: height * (8 / 844),
                bottom: height * (16 / 844),
              ),
              child: Text(
                ' اكتب هنا وصف المنتج',
                style: TextStyle(
                  color: Color(0xff55585B),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * (16 / 390)),
              child: Divider(color: Color(0xffF8F8F8), thickness: 1),
            ),

            SizedBox(height: height * (16 / 844)),
            Padding(
              padding: EdgeInsets.only(right: width * (16 / 390)),
              child: Text(
                'اللون',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: height * (16 / 844)),

            Padding(
              padding: EdgeInsets.only(
                right: width * (16 / 390),
                bottom: height * (16 / 844),
                left: width * (16 / 390),
              ),
              child: CustomDropdown(
                width: double.infinity,
                height: 48,
                items: size,
                selectedValue: selectedSize,
                hintText: 'اختر اللون',
                onChanged: (value) {},
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * (16 / 390)),
              child: Divider(color: Color(0xffF8F8F8), thickness: 1),
            ),

            SizedBox(height: height * (16 / 844)),

            Padding(
              padding: EdgeInsets.only(right: width * (16 / 390)),
              child: Text(
                'المقاس',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: height * (16 / 844)),

            Padding(
              padding: EdgeInsets.only(
                right: width * (16 / 390),
                bottom: height * (16 / 844),
                left: width * (16 / 390),
              ),
              child: CustomDropdown(
                width: double.infinity,
                height: 48,
                items: color,
                selectedValue: selectedColor,
                hintText: 'اختر المقاس',
                onChanged: (value) {},
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * (16 / 390)),
              child: Divider(color: Color(0xffF8F8F8), thickness: 1),
            ),

            SizedBox(height: height * (16 / 844)),

            Padding(
              padding: EdgeInsets.only(right: width * (16 / 390)),
              child: Text(
                'الكمية',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: height * (16 / 844)),

            Padding(
              padding: EdgeInsets.only(right: width * (16 / 390)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: height * 35 / 844,
                    decoration: BoxDecoration(
                      color: Color(0xffF3F5F6),
                      border: Border.all(
                        width: 1,
                        color: Color.fromARGB(255, 214, 214, 214),
                      ),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.remove,
                            size: 14,
                            color: Color(0xff55585B),
                          ),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(
                            minWidth: 28,
                            minHeight: 28,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: width * 0.016,
                          ),
                          decoration: const BoxDecoration(
                            border: Border.symmetric(
                              vertical: BorderSide(color: Color(0xffF3F5F6)),
                            ),
                          ),
                          child: Text(
                            '2',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff55585B),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.add,
                            size: 14,
                            color: Color(0xff55585B),
                          ),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(
                            minWidth: 28,
                            minHeight: 28,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: height * (16 / 844)),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * (16 / 390)),
              child: Divider(color: Color(0xffF8F8F8), thickness: 1),
            ),

            //  SizedBox(height: 40,),
            //  Padding(
            //    padding:  EdgeInsets.symmetric(horizontal: width*(16/390)),
            //    child: DefaultButton(text: 'اضف الي السلة', onTap: (){}),
            //  ),

            //                     SizedBox(height: 40,),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * (16 / 390)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DefaultButton(text: 'أضف إلى السلة', onTap: () {}),
            SizedBox(height: height * (20 / 844)),
          ],
        ),
      ),
    );
  }
}
