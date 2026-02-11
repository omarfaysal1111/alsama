import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_state.dart';
import '../../../auth/presentation/widgets/logout_dialog.dart';

class MenuWidget extends StatelessWidget {
  const MenuWidget({super.key});

  void _closeMenu(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }

  void _openRoute(BuildContext context, String routeName) {
    _closeMenu(context);
    Navigator.pushNamed(context, routeName);
  }

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthBloc>().state;
    final isLoggedIn =
        authState is Authenticated && authState.user.id.trim().isNotEmpty;
    final userName =
        isLoggedIn && authState.user.name.trim().isNotEmpty
            ? authState.user.name.trim()
            : 'زائر';
    final userEmail =
        isLoggedIn && authState.user.email.trim().isNotEmpty
            ? authState.user.email.trim()
            : 'guest@example.com';

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
                userName,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 12),
              Text(
                userEmail,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12, // 🔹 حجم الخط 12px
                  color: Color(0xff55585B),
                ),
              ),

              SizedBox(height: 80),

              GestureDetector(
                onTap:
                    () => _openRoute(
                      context,
                      isLoggedIn ? AppRoutes.profile : AppRoutes.login,
                    ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'الملف الشخصي',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff1C1C1C),
                      ),
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
                onTap: () => _openRoute(context, AppRoutes.wishlist),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      ' المفضلة',

                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Color(0xff1C1C1C),
                      ),
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
                onTap: () => _openRoute(context, AppRoutes.cart),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      ' السلة',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,

                        fontSize: 18,
                        color: Color(0xff1C1C1C),
                      ),
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
                onTap: () => _openRoute(context, AppRoutes.categories),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'الاقسام',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,

                        fontSize: 18,
                        color: Color(0xff1C1C1C),
                      ),
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
                onTap: () {
                  _closeMenu(context);
                  showDialog(
                    context: context,
                    builder: (_) => const LogoutDialog(),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'تسجيل الخروج',
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
