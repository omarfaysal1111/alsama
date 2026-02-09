import 'package:alsama/features/auth/presentation/widgets/default_button.dart';
import 'package:flutter/material.dart';

class FilterWidget extends StatefulWidget {
  const FilterWidget({super.key});

  @override
  State<FilterWidget> createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  RangeValues priceRange = const RangeValues(150, 600);
  String? selectedCategory;

  final List<String> categories = ['إسدال', 'عبايات', 'ادناء'];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Align(
      alignment: Alignment.centerRight,
      child: Material(
        child: Container(
          width: width * 0.8,
          height: height,
          color: Colors.white,
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.05,
            vertical: height * 0.06,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      'تصفية المنتجات',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * 0.06),

                // السعر
                const Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'السعر',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ),

                RangeSlider(
                  values: priceRange,
                  min: 0,
                  max: 1500,
                  divisions: 30,

                  labels: RangeLabels(
                    '${priceRange.start.round()} ج.م',
                    '${priceRange.end.round()} ج.م',
                  ),
                  activeColor: const Color(0xff821F40),
                  inactiveColor: Colors.grey[300],
                  onChanged: (RangeValues values) {
                    setState(() {
                      priceRange = values;
                    });
                  },
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          '${priceRange.start.round()} ج.م',
                          softWrap: true,
                        ),
                      ),
                      Flexible(
                        child: Text(
                          '${priceRange.end.round()} ج.م',
                          textAlign: TextAlign.end,
                          softWrap: true,
                            
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: height * 0.03),

                // الأقسام
                const Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'القسم',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ),
                SizedBox(height: height * 0.015),
                Column(
                  children:
                      categories.map((category) {
                        bool isSelected = selectedCategory == category;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedCategory = category;
                              });
                            },
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color:
                                    isSelected
                                        ? const Color(0xff7D173C)
                                        : Colors.transparent,
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Text(
                                category,
                                style: TextStyle(
                                  color:
                                      isSelected ? Colors.white : Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                ),

                SizedBox(height: height * 0.04),

                // الأزرار
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(


                      
                      onPressed: () => Navigator.pop(context),
                      child:  Text(
                        'إلغاء',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14
                        ),
                        ),
                    ),

                    SizedBox(
                      width:width*(132/390) ,
                      height: height*(40/844),
                      child: DefaultButton(text: 'تأكيد', onTap: (){
                                                Navigator.pop(context);
                      
                      
                      }),
                    )

                    
                    
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
