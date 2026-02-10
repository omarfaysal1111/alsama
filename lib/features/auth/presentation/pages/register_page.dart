import 'package:alsama/features/auth/presentation/widgets/default_button.dart';
import 'package:alsama/features/auth/presentation/widgets/register_form.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController usernameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();

    TextEditingController loc1Controller = TextEditingController();
    TextEditingController loc2Controller = TextEditingController();

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final ValueNotifier<bool> isChecked = ValueNotifier(false);
    final ValueNotifier<bool> isChecked2 = ValueNotifier(false);

    return Scaffold(
      body: SingleChildScrollView(
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
                          scale: 1.0, //    
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
                child: DefaultButton(onTap: () {}, text: 'تسجيل الدخول'),
              ),
              SizedBox(height: height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {},
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
      ),
    );
  }
}
