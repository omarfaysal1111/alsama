import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class TextFieldRegister extends StatelessWidget {
  final TextEditingController emailController;
  final ValueChanged<String> onChanged;
  final String hinttext;
  final IconData icon;
  final Widget? prefixIcon;

  const TextFieldRegister({
    super.key,
    required this.emailController,
    required this.onChanged,
    required this.hinttext,
    required this.icon,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: emailController,
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.right,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hinttext,
        hintStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Color(0xffADAFB1),
        ),

        prefixIcon: prefixIcon,
        suffixIcon: Icon(icon, size: 24, color: Color(0xff55585B)),
        filled: true,
        fillColor: const Color(0xffF8F8F8),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(0)),
          borderSide: BorderSide(color: Color(0xffE0E2E3), width: 1),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(0)),
          borderSide: BorderSide(color: Color(0xff821F40), width: 1),
        ),
      ),
    );
  }
}
