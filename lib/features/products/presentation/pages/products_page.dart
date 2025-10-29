import 'package:alsama/features/products/presentation/widgets/filter_widget.dart';
import 'package:flutter/material.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'اسم القسم',
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

        actions: [
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.only(right: width * (16.0 / 390)),
              child: SizedBox(
                width: 24,
                height: 24,
                child: Image.asset('assets/images/shopping-bag.png'),
              ),
            ),
          ),
        ],
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * (16 / 390)),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: width * (290 / 390),
                  height: height * (49 / 844),
                  child: TextField(
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                      hintText: '...ابحث هنا',
                      hintStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xffADAFB1),
                      ),
                      suffixIcon: const Icon(
                        Icons.search,
                        size: 24,
                        color: Color(0xff55585B),
                      ),

                      filled: true,

                      fillColor: Color(0xffF8F8F8),

                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(0)),
                        borderSide: BorderSide(
                          color: const Color(0xffE0E2E3),
                          width: 1,
                        ),
                      ),

                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(0)),
                        borderSide: BorderSide(
                          color: Color(0xff821F40),
                          width: 1,
                        ),
                      ),
                    ),
                    onSubmitted: (query) {
                      // if (query.isNotEmpty) {
                      //   context.read<ProductsBloc>().add(
                      //     SearchProductsRequested(query: query),
                      //   );
                      // }
                    },
                  ),
                ),

               GestureDetector(
  onTap: () {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'فلتر المنتجات',
      barrierColor: Colors.black.withOpacity(0.4),
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (context, animation, secondaryAnimation) {
        // ✅ هنا نحط FilterWidget بشكل آمن
        return Align(
          alignment: Alignment.centerRight,
          child: FilterWidget(),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        // ✅ نحرك الـ child اللي جاي من pageBuilder
        final offsetAnimation = Tween<Offset>(
          begin: const Offset(1.0, 0.0), // يبدأ من اليمين
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
        ));

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  },
  child: Container(
    width: width * (51 / 390),
    height: height * (49 / 844),
    decoration: BoxDecoration(
      color: const Color(0xffF8F8F8),
      border: Border.all(color: const Color(0xffE0E2E3)),
    ),
    child: Center(
      child: Image.asset(
        'assets/images/Filter.png',
        width: width * (24 / 390),
        height: height * (24 / 844),
      ),
    ),
  ),
)

              ],
            ),
          ],
        ),
      ),
    );
  }
}
