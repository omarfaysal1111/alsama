import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  final double width;
  final double height;
  final List<String> items;
  final String? selectedValue;
  final String hintText;
  final ValueChanged<String?> onChanged;

  const CustomDropdown({
    super.key,
    required this.width,
    required this.height,
    required this.items,
    required this.selectedValue,
    required this.hintText,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xffF3F5F6),
        border: Border.all(color: const Color(0xffE6E6E6)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedValue,
          hint: Align(
            alignment: Alignment.centerRight,
            child: Text(
              hintText,
              style: const TextStyle(
                color: Color(0xff55585B),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xff55585B)),
          isExpanded: true,
          dropdownColor: Colors.white,
          onChanged: onChanged,
          items:
              items
                  .map(
                    (item) => DropdownMenuItem<String>(
                      value: item,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
        ),
      ),
    );
  }
}
