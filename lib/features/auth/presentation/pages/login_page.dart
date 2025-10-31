import 'package:alsama/features/auth/presentation/widgets/default_button.dart';
import 'package:alsama/features/auth/presentation/widgets/register_form.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
TextEditingController emailController = TextEditingController();  
TextEditingController passwordController =TextEditingController(); 


double height =MediaQuery.of(context).size.height;
double width =MediaQuery.of(context).size.width;

 return  Scaffold(
      body: Padding(
        padding:  EdgeInsets.only(top: height* 136/844,left: 16,right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
        
Text('  تسجيل دخول',style: TextStyle(
  fontSize: 34,
  fontWeight: FontWeight.bold
),),


         Padding(
           padding:  EdgeInsets.only(top: height*0.2),
           child: TextFieldRegister(
            emailController: emailController,
            hinttext: 'البريد الالكتروني',
            icon: Icons.email_outlined
            ,onChanged:  (value) {
              
            },),
         ),
                
        Padding(
           padding:  EdgeInsets.only(top: 16),
           child: TextFieldRegister(
            emailController: passwordController,
            hinttext: ' كلمة المرور',
            icon: Icons.lock_outline,
           
    prefixIcon: Icon(Icons.remove_red_eye_outlined, color: Color(0xff55585B)),
            onChanged:  (value) {
              
            },),
         ),


Padding(
  padding: const EdgeInsets.only(top: 90.0),
  child: DefaultButton(onTap: (){},text: 'تسجيل الدخول',),
)      ,
SizedBox(height:height*0.02 ,),
Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [

    GestureDetector(
      onTap: (){},
      child: Text(' أنشئ حسابًا جديدً' , style: TextStyle(color:Color(0xff821F40) ,fontSize: 14),)),
    Text('ليس لديك حساب؟' , style: TextStyle(color: Color(0xff333333),fontSize: 14),),

    
  ],
)
          ],
        ),
      ),
    );
  }
}