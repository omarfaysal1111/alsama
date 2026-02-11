import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color backgroundColor;
  final TextStyle? textStyle;

  const DefaultButton({
    super.key,
    required this.text,
    required this.onTap,
    this.backgroundColor = const Color(0xff821F40),
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: 56,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: backgroundColor,
        ),
        child: Text(
          text,
          style: textStyle ??
              const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                            ),
        ),
      ),
    );
  }
}
