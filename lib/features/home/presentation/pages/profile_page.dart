import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'اسم المستخدم',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: height * 0.01),
                Text(
                  'user@gmial.com',
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12, // 🔹 حجم الخط 12px
                    color: Color(0xff55585B),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(height: height * 0.03),
            Text(
              ' خيارات الحساب',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: height * 0.014),

            FavoriteHeaderCard(
              title: 'المفضلة',
              icons: Icons.favorite_border_outlined,
              onClick: () {},
            ),

             Padding(
               padding:  EdgeInsets.only(top: height*0.016),
               child: FavoriteHeaderCard(
                title: 'عنواني',
                icons: Icons.location_on_outlined,
                onClick: () {},
                           ),
             ),




              SizedBox(height: height * 0.03),
            Text(
              'الإعدادات & المساعدة',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: height * 0.014),

            FavoriteHeaderCard(
              title: 'الإعدادات',
              icons: Icons.settings,
              onClick: () {},
            ),

             Padding(
               padding:  EdgeInsets.only(top: height*0.016),
               child: FavoriteHeaderCard(
                title: 'مركز المساعدة',
                icons: Icons.help_center_outlined,
                onClick: () {},
                           ),
             ),
          ],
        ),
      ),
    );
  }
}

class FavoriteHeaderCard extends StatelessWidget {
  final String title;
  final VoidCallback? onClick;
  final IconData icons;

  const FavoriteHeaderCard({
    super.key,
    required this.title,
    required this.onClick,
    required this.icons,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: 60,
      color: const Color(0xffF8F8F8),
      padding: EdgeInsets.symmetric(horizontal: width * 0.04),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: onClick,
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                title,
                textDirection: TextDirection.rtl,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),

              SizedBox(width: width * 0.012),

              Icon(icons, color: Colors.black),
            ],
          ),
        ],
      ),
    );
  }
}
