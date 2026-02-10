import 'package:alsama/features/auth/presentation/widgets/default_button.dart';
import 'package:alsama/features/auth/presentation/widgets/register_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/routes/app_routes.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController loc1Controller = TextEditingController();
  final TextEditingController loc2Controller = TextEditingController();
  
  final ValueNotifier<bool> isChecked = ValueNotifier(false);
  final ValueNotifier<bool> isChecked2 = ValueNotifier(false);

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    phoneController.dispose();
    loc1Controller.dispose();
    loc2Controller.dispose();
    isChecked.dispose();
    isChecked2.dispose();
    super.dispose();
  }

  void _handleRegister() {
    if (!isChecked2.value) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('يجب الموافقة على الشروط والأحكام'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        usernameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('الرجاء ملء جميع الحقول المطلوبة'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    context.read<AuthBloc>().add(
      RegisterRequested(
        email: emailController.text,
        password: passwordController.text,
        name: usernameController.text,
        phone: phoneController.text.isNotEmpty ? phoneController.text : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('تم التسجيل بنجاح'),
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
            
            return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: height * 110 / 844,
            left: 16,
            right: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'انشاء حساب جديد',
                style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
              ),

              Padding(
                padding: EdgeInsets.only(top: height * 0.08),
                child: TextFieldRegister(
                  keyboardType: keyboardT.email,

                  emailController: emailController,
                  hinttext: 'البريد الالكتروني',
                  icon: Icons.email_outlined,
                  onChanged: (value) {},
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: TextFieldRegister(
                  keyboardType: keyboardT.email,

                  emailController: usernameController,
                  hinttext: ' اسم المستخددم',
                  icon: Icons.person_2_outlined,
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
                padding: EdgeInsets.only(top: 16),
                child: TextFieldRegister(
                  keyboardType: keyboardT.number,

                  emailController: phoneController,
                  hinttext: 'التليفون',
                  icon: Icons.phone_outlined,
                  onChanged: (value) {},
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: TextFieldRegister(
                  keyboardType: keyboardT.email,

                  emailController: loc1Controller,
                  hinttext: 'العنوان (المدينة)',
                  icon: Icons.location_on_outlined,
                  onChanged: (value) {},
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: TextFieldRegister(
                  keyboardType: keyboardT.email,

                  emailController: loc2Controller,
                  hinttext: 'اسم الشارع',
                  icon: Icons.location_on_outlined,
                  onChanged: (value) {},
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      ' التسجيل كتاجر',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Color(0xff333333),
                      ),
                    ),

                    SizedBox(width: 4),

                    ValueListenableBuilder<bool>(
                      valueListenable: isChecked,
                      builder: (context, value, _) {
                        return Transform.scale(
                          scale: 1.0, // ممكن تغيري الحجم لو عايزة
                          child: Checkbox(
                            value: value,
                            onChanged: (newValue) {
                              isChecked.value = newValue!;
                            },
                            visualDensity: const VisualDensity(
                              horizontal: -4,
                              vertical: -4,
                            ),
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            side:
                                value
                                    ? null
                                    : const BorderSide(
                                      color: Color(0xFF6D6D6D),
                                      width: 2,
                                    ),
                            fillColor: MaterialStateProperty.resolveWith((
                              states,
                            ) {
                              if (states.contains(MaterialState.selected)) {
                                return const Color(0xff821F40);
                              }
                              return Colors.transparent;
                            }),
                            checkColor: Colors.white,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      'أوافق على شروط الخدمة وسياسةالخصوصية',
                      style: TextStyle(fontSize: 14, color: Color(0xff333333)),
                    ),
                    SizedBox(width: 4),

                    ValueListenableBuilder<bool>(
                      valueListenable: isChecked2,
                      builder: (context, value, _) {
                        return Checkbox(
                          value: value,
                          onChanged: (newValue) {
                            isChecked2.value = newValue!;
                          },
                          visualDensity: const VisualDensity(
                            horizontal: -4,
                            vertical: -4,
                          ),
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          side:
                              value
                                  ? null
                                  : const BorderSide(
                                    color: Color(0xFF6D6D6D),
                                    width: 2,
                                  ),
                          fillColor: MaterialStateProperty.resolveWith((
                            states,
                          ) {
                            if (states.contains(MaterialState.selected)) {
                              return const Color(0xff821F40);
                            }
                            return Colors.transparent;
                          }),
                          checkColor: Colors.white,
                        );
                      },
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: DefaultButton(
                  onTap: isLoading ? () {} : _handleRegister,
                  text: isLoading ? 'جاري التسجيل...' : 'تسجيل',
                ),
              ),
              SizedBox(height: height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, AppRoutes.login);
                    },
                    child: Text(
                      'سجّل دخولك',
                      style: TextStyle(color: Color(0xff821F40), fontSize: 14),
                    ),
                  ),
                  SizedBox(width: 4),
                  Text(
                    'لديك حساب بالفعل؟ ',
                    style: TextStyle(color: Color(0xff333333), fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
        ),
            );
          },
        ),
      ),
    );
  }
}
