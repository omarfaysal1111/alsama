import 'package:alsama/features/auth/presentation/widgets/logout_dialog.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
          surfaceTintColor: Colors.white,
        foregroundColor: Colors.white,
        backgroundColor: Colors.white,
        elevation: 0,
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
            SizedBox(height: height * 0.04),
            Text(
              ' خيارات الحساب',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: height * 0.016),

            FavoriteHeaderCard(
              title: 'المفضلة',
              icons: Icons.favorite_border_outlined,
              onClick: () {},
            ),

            //  Padding(
            //    padding:  EdgeInsets.only(top: height*0.016),
            //    child: FavoriteHeaderCard(
            //     title: 'عنواني',
            //     icons: Icons.location_on_outlined,
            //     onClick: () {},
            //                ),
            //  ),




              SizedBox(height: height * 0.016),
        
            FavoriteHeaderCard(
              title: 'تسجيل الخروج',
              icons: Icons.logout_outlined,
              onClick: () {
                showDialog(context: context, builder: (context) {
                  return LogoutDialog();
                },);
              },
            ),

             Padding(
               padding:  EdgeInsets.only(top: height*0.016),
               child: FavoriteHeaderCard(
                textColor: Color(0xff821F40),
                iconColor: Color(0xff821F40),
                title: ' حذف الحساب',
              
                icons: Icons.person_off_outlined
                ,

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
final Color? iconColor;
final Color ?textColor;
  const FavoriteHeaderCard({
    super.key,
    required this.title,
    required this.onClick,
    required this.icons, this.iconColor, this.textColor,

  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: 60,
      color: const Color(0xffF8F8F8),
      padding: EdgeInsets.symmetric(horizontal: width * 0.04),
      child: GestureDetector(
        onTap: onClick,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
                Icons.arrow_back_ios_new, color: Colors.black,
            ),
        
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  title,
                  textDirection: TextDirection.rtl,
                  style:  TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: textColor ?? Colors.black,
                  ),
                ),
        
                SizedBox(width: width * 0.012),
        
                Icon(icons, color: iconColor?? Colors.black),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
