import 'package:alsama/features/auth/presentation/widgets/default_button.dart';
import 'package:alsama/features/auth/presentation/widgets/register_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/routes/app_routes.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('الرجاء إدخال اسم المستخدم وكلمة المرور'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    context.read<AuthBloc>().add(
      LoginRequested(
        email: emailController.text,  // Can be username or email
        password: passwordController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    // double width =MediaQuery.of(context).size.width;

    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('تم تسجيل الدخول بنجاح'),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pushReplacementNamed(context, AppRoutes.home);
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            final isLoading = state is AuthLoading;

            return Padding(
              padding: EdgeInsets.only(top: height * 136 / 844, left: 16, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
            Text(
              '  تسجيل دخول',
              style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
            ),

            Padding(
              padding: EdgeInsets.only(top: height * 0.2),
              child: TextFieldRegister(
                keyboardType: keyboardT.email,

                emailController: emailController,
                hinttext: 'البريد الالكتروني أو اسم المستخدم',
                icon: Icons.email_outlined,
                onChanged: (value) {},
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: 16),
              child: TextFieldRegister(
                keyboardType: keyboardT.email,

                emailController: passwordController,
                hinttext: ' كلمة المرور',
                icon: Icons.lock_outline,

                prefixIcon: Icon(
                  Icons.remove_red_eye_outlined,
                  color: Color(0xff55585B),
                ),
                onChanged: (value) {},
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 90.0),
              child: DefaultButton(
                onTap: isLoading ? () {} : _handleLogin,
                text: isLoading ? 'جاري تسجيل الدخول...' : 'تسجيل الدخول',
              ),
            ),
            SizedBox(height: height * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.register);
                  },
                  child: Text(
                    ' أنشئ حسابًا جديدً',
                    style: TextStyle(color: Color(0xff821F40), fontSize: 14),
                  ),
                ),
                SizedBox(width: 4),

                Text(
                  'ليس لديك حساب؟',
                  style: TextStyle(color: Color(0xff333333), fontSize: 14),
                ),
              ],
            ),
          ],
              ),
            );
          },
        ),
      ),
    );
  }
}
