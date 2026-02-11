import 'package:alsama/features/auth/presentation/widgets/default_button.dart';
import 'package:flutter/material.dart';

class ProductFilterResult {
  final double minPrice;
  final double maxPrice;
  final String? sortBy;
  final String? sortOrder;

  const ProductFilterResult({
    required this.minPrice,
    required this.maxPrice,
    this.sortBy,
    this.sortOrder,
  });
}

class FilterWidget extends StatefulWidget {
  final double initialMinPrice;
  final double initialMaxPrice;
  final String? initialSortBy;
  final String? initialSortOrder;
  final double maxSelectablePrice;
  final ValueChanged<ProductFilterResult> onApply;

  const FilterWidget({
    super.key,
    required this.initialMinPrice,
    required this.initialMaxPrice,
    required this.onApply,
    this.initialSortBy,
    this.initialSortOrder,
    this.maxSelectablePrice = 1500,
  });

  @override
  State<FilterWidget> createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  late RangeValues priceRange;
  String? _sortBy;
  String? _sortOrder;

  static const List<_SortOption> _sortOptions = [
    _SortOption(label: 'الأحدث', sortBy: 'newest', sortOrder: 'desc'),
    _SortOption(
      label: 'السعر: الأقل للأعلى',
      sortBy: 'price',
      sortOrder: 'asc',
    ),
    _SortOption(
      label: 'السعر: الأعلى للأقل',
      sortBy: 'price',
      sortOrder: 'desc',
    ),
    _SortOption(label: 'الاسم: أ - ي', sortBy: 'name', sortOrder: 'asc'),
  ];

  @override
  void initState() {
    super.initState();
    final safeMin = widget.initialMinPrice.clamp(0, widget.maxSelectablePrice);
    final safeMax = widget.initialMaxPrice.clamp(0, widget.maxSelectablePrice);
    final start = safeMin <= safeMax ? safeMin : 0.0;
    final end = safeMin <= safeMax ? safeMax : widget.maxSelectablePrice;

    priceRange = RangeValues(start.toDouble(), end.toDouble());
    _sortBy = widget.initialSortBy;
    _sortOrder = widget.initialSortOrder;
  }

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
                  max: widget.maxSelectablePrice,
                  divisions: 30,

                  labels: RangeLabels(
                    '${priceRange.start.round()} EGP',
                    '${priceRange.end.round()} EGP',
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
                          '${priceRange.start.round()} EGP',
                          softWrap: true,
                        ),
                      ),
                      Flexible(
                        child: Text(
                          '${priceRange.end.round()} EGP',
                          textAlign: TextAlign.end,
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: height * 0.03),
                const Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'الترتيب',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ),
                SizedBox(height: height * 0.015),
                ..._sortOptions.map((option) {
                  final isSelected =
                      _sortBy == option.sortBy &&
                      _sortOrder == option.sortOrder;
                  return RadioListTile<bool>(
                    value: true,
                    groupValue: isSelected,
                    onChanged: (_) {
                      setState(() {
                        _sortBy = option.sortBy;
                        _sortOrder = option.sortOrder;
                      });
                    },
                    title: Text(
                      option.label,
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.right,
                    ),
                    contentPadding: EdgeInsets.zero,
                    controlAffinity: ListTileControlAffinity.trailing,
                    activeColor: const Color(0xff821F40),
                  );
                }),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _sortBy = null;
                      _sortOrder = null;
                    });
                  },
                  child: const Text('إلغاء الترتيب'),
                ),

                SizedBox(height: height * 0.04),

                // الأزرار
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'إلغاء',
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ),
                    ),

                    SizedBox(
                      width: width * (132 / 390),
                      height: height * (40 / 844),
                      child: DefaultButton(
                        text: 'تأكيد',
                        onTap: () {
                          widget.onApply(
                            ProductFilterResult(
                              minPrice: priceRange.start,
                              maxPrice: priceRange.end,
                              sortBy: _sortBy,
                              sortOrder: _sortOrder,
                            ),
                          );
                          Navigator.pop(context);
                        },
                      ),
                    ),
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

class _SortOption {
  final String label;
  final String sortBy;
  final String sortOrder;

  const _SortOption({
    required this.label,
    required this.sortBy,
    required this.sortOrder,
  });
}
