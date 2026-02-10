import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  final List<String> items;
  final String? selectedValue;
  final ValueChanged<String?> onChanged;
  final String hintText;
  final double? width;
  final double? height;
  final Color? backgroundColor;

  const CustomDropdown({
    super.key,
    required this.items,
    required this.selectedValue,
    required this.onChanged,
    this.hintText = 'اختار',
    this.width,
    this.height,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height ?? 50,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: backgroundColor ?? const Color(0xffF3F5F6),
        border: Border.all(color: Color(0xffE9EAEB)),
        borderRadius: BorderRadius.circular(8)
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            isExpanded: true,
            icon: const Icon(Icons.keyboard_arrow_down),
            value: selectedValue,
            hint: Text(
              hintText,
              style: const TextStyle(
                color: Color.fromARGB(255, 44, 44, 44),
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            items:
                items.map((item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      textDirection: TextDirection.rtl,
                      style: const TextStyle(fontSize: 14, color: Colors.black),
                    ),
                  );
                }).toList(),
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }
}
