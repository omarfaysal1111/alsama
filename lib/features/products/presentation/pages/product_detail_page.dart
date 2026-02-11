import 'package:alsama/features/auth/presentation/widgets/default_button.dart';
import 'package:alsama/features/products/presentation/widgets/custom_dropdown.dart';
import 'package:alsama/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:alsama/features/cart/presentation/bloc/cart_event.dart';
import 'package:alsama/features/cart/presentation/bloc/cart_state.dart';
import 'package:alsama/core/constants/api_endpoints.dart';
import 'package:alsama/core/constants/app_constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/product.dart';

class _OptionItem {
  final String id;
  final String name;

  const _OptionItem({required this.id, required this.name});
}

class ProductDetailPage extends StatefulWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final Dio _dio = Dio();
  String? selectedSize;
  String? selectedColor;
  int quantity = 1;
  List<_OptionItem> _colors = [];
  List<_OptionItem> _sizes = [];
  bool _loadingColors = false;
  bool _loadingSizes = false;

  bool get _hasSelectedRequiredOptions =>
      selectedColor != null && selectedSize != null;

  @override
  void initState() {
    super.initState();
    _fetchColors();
    selectedImage = widget.product.img;
  }

  Future<void> _fetchColors() async {
    setState(() {
      _loadingColors = true;
    });

    try {
      final response = await _dio.get(
        '${ApiEndpoints.getColorsByModel}/${widget.product.id}',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${AppConstants.bearerToken}',
            'Content-Type': 'application/json',
          },
        ),
      );

      final data = response.data;
      final List<dynamic> list =
          data is List
              ? data
              : (data is Map<String, dynamic> && data['data'] is List
                  ? data['data'] as List<dynamic>
                  : (data is Map<String, dynamic> && data['records'] is List
                      ? data['records'] as List<dynamic>
                      : <dynamic>[]));

      final colors =
          list
              .whereType<Map>()
              .map(
                (e) => _OptionItem(
                  id: e['id']?.toString() ?? '',
                  name: e['name']?.toString() ?? '',
                ),
              )
              .where((e) => e.id.isNotEmpty && e.name.isNotEmpty)
              .toList();

      setState(() {
        _colors = colors;
      });
    } catch (_) {
      setState(() {
        _colors = [];
      });
    } finally {
      if (mounted) {
        setState(() {
          _loadingColors = false;
        });
      }
    }
  }

  Future<void> _fetchSizesForColor(String colorId) async {
    setState(() {
      _loadingSizes = true;
      _sizes = [];
      selectedSize = null;
    });

    try {
      final response = await _dio.post(
        ApiEndpoints.getSizes,
        data: {'modelid': widget.product.id.toString(), 'colorid': colorId},
        options: Options(
          headers: {
            'Authorization': 'Bearer ${AppConstants.bearerToken}',
            'Content-Type': 'application/json',
          },
        ),
      );

      final data = response.data;
      final List<dynamic> list =
          data is List
              ? data
              : (data is Map<String, dynamic> && data['data'] is List
                  ? data['data'] as List<dynamic>
                  : (data is Map<String, dynamic> && data['records'] is List
                      ? data['records'] as List<dynamic>
                      : <dynamic>[]));

      final sizes =
          list
              .whereType<Map>()
              .map(
                (e) => _OptionItem(
                  id: e['id']?.toString() ?? '',
                  name: e['name']?.toString() ?? '',
                ),
              )
              .where((e) => e.id.isNotEmpty && e.name.isNotEmpty)
              .toList();

      setState(() {
        _sizes = sizes;
      });
    } catch (_) {
      setState(() {
        _sizes = [];
      });
    } finally {
      if (mounted) {
        setState(() {
          _loadingSizes = false;
        });
      }
    }
  }

  String _resolveColorId() {
    final selected = _colors.where((e) => e.name == selectedColor);
    return selected.isNotEmpty ? selected.first.id : '';
  }

  String _resolveSizeId() {
    final selected = _sizes.where((e) => e.name == selectedSize);
    return selected.isNotEmpty ? selected.first.id : '';
  }

  void _addToCart() {
    if (!_hasSelectedRequiredOptions) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('من فضلك اختر اللون والمقاس أولاً'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Create product with selected color and size IDs
    final productWithOptions = widget.product.copyWith(
      colorId: _resolveColorId(),
      sizeId: _resolveSizeId(),
    );

    context.read<CartBloc>().add(
      AddProductToCartRequested(
        product: productWithOptions,
        quantity: quantity,
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('تم إضافة المنتج إلى السلة'),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'عرض السلة',
          textColor: Colors.white,
          onPressed: () {
            Navigator.pushNamed(context, '/cart');
          },
        ),
      ),
    );
  }

  void _incrementQuantity() {
    if (quantity < widget.product.quantity) {
      setState(() {
        quantity++;
      });
    }
  }

  void _decrementQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  late String selectedImage;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        foregroundColor: Colors.white,
        backgroundColor: Colors.white,
        elevation: 0,
        shadowColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: height * (16 / 844)),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                switchInCurve: Curves.easeInOut,
                switchOutCurve: Curves.easeIn,
                // transitionBuilder: (child, animation) {
                //   return FadeTransition(
                //     opacity: animation,
                //     child: ScaleTransition(
                //       scale: Tween<double>(begin: 0.95, end: 1.0).animate(animation),
                //       child: child,
                //     ),
                //   );
                // },
                child: ClipRRect(
                  key: ValueKey(selectedImage),

                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    width: double.infinity,
                    height: height * (500 / 844),
                    decoration: BoxDecoration(
                      color: Color(0xffF3F5F6),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: selectedImage,

                      // imageUrl: widget.product.img,
                      fit: BoxFit.cover,
                      placeholder:
                          (context, url) =>
                              const Center(child: CircularProgressIndicator()),
                      errorWidget:
                          (context, url, error) => const Icon(
                            Icons.image_not_supported,
                            size: 80,
                            color: Colors.grey,
                          ),
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * (16 / 390)),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ' EGP ${widget.product.finalPrice.toStringAsFixed(0)} ',
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              color: Color(0xff821F40),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (widget.product.hasDiscount)
                            Text(
                              ' EGP ${widget.product.price.toStringAsFixed(0)} ',
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                        ],
                      ),

                      Expanded(
                        child: Text(
                          widget.product.title,
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height * (16 / 844)),

                  // const Divider(color: Color(0xffF8F8F8), thickness: 1),
                  SizedBox(height: height * (12 / 844)),

                  // Product images gallery
                  if (widget.product.imageURLs.isNotEmpty)
                    SizedBox(
                      height: height * (80 / 844),
                      child: Directionality(
                        textDirection: TextDirection.rtl,

                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: widget.product.imageURLs.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(
                                left: width * (16 / 390),
                                bottom: height * (16 / 844),
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedImage =
                                        widget.product.imageURLs[index].img;
                                  });
                                },

                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color:
                                          selectedImage ==
                                                  widget
                                                      .product
                                                      .imageURLs[index]
                                                      .img
                                              ? const Color.fromARGB(
                                                255,
                                                12,
                                                12,
                                                12,
                                              ).withOpacity(0.7)
                                              : Colors.transparent,
                                      width: 2,
                                    ),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Container(
                                      width: width * (60 / 390),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Color(0xffF3F5F6),
                                      ),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            widget.product.imageURLs[index].img,
                                        fit: BoxFit.cover,
                                        errorWidget:
                                            (context, url, error) =>
                                                const Icon(Icons.image),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                  //  const Divider(color: Color(0xffF8F8F8), thickness: 1),
                  SizedBox(height: height * (16 / 844)),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.only(right: width * (16 / 390)),
              child: const Text(
                'وصف المنتج',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(
                right: width * (16 / 390),
                top: height * (8 / 844),
                bottom: height * (16 / 844),
                left: width * (16 / 390),
              ),
              child: Text(
                widget.product.description,
                textAlign: TextAlign.right,
                style: const TextStyle(
                  color: Color(0xff55585B),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: width * (16 / 390)),
            //   child: const Divider(color: Color(0xffF8F8F8), thickness: 1),
            // ),

            // Stock status
            if (!widget.product.isInStock)
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: width * (16 / 390),
                  vertical: height * (8 / 844),
                ),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'المنتج غير متوفر حالياً',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.error_outline, color: Colors.red),
                    ],
                  ),
                ),
              ),

            SizedBox(height: height * (16 / 844)),
            Padding(
              padding: EdgeInsets.only(right: width * (16 / 390)),
              child: const Text(
                'اللون',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: height * (16 / 844)),

            Padding(
              padding: EdgeInsets.only(
                right: width * (16 / 390),
                bottom: height * (16 / 844),
                left: width * (16 / 390),
              ),
              child: CustomDropdown(
                width: double.infinity,
                height: 48,
                items: _colors.map((e) => e.name).toList(),
                selectedValue: selectedColor,
                hintText:
                    _loadingColors
                        ? 'جاري تحميل الألوان...'
                        : (_colors.isEmpty
                            ? 'لا توجد ألوان متاحة'
                            : 'اختر اللون'),
                onChanged: (value) {
                  final color = _colors.where((e) => e.name == value);
                  final colorId = color.isNotEmpty ? color.first.id : '';
                  setState(() {
                    selectedColor = value;
                    selectedSize = null;
                    _sizes = [];
                  });
                  if (colorId.isNotEmpty) {
                    _fetchSizesForColor(colorId);
                  }
                },
              ),
            ),

            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: width * (16 / 390)),
            //   child: const Divider(color: Color(0xffF8F8F8), thickness: 1),
            // ),
            SizedBox(height: height * (16 / 844)),

            Padding(
              padding: EdgeInsets.only(right: width * (16 / 390)),
              child: const Text(
                'المقاس',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: height * (16 / 844)),

            Padding(
              padding: EdgeInsets.only(
                right: width * (16 / 390),
                bottom: height * (16 / 844),
                left: width * (16 / 390),
              ),
              child: CustomDropdown(
                width: double.infinity,
                height: 48,
                items: _sizes.map((e) => e.name).toList(),
                selectedValue: selectedSize,
                hintText:
                    _loadingSizes
                        ? 'جاري تحميل المقاسات...'
                        : (_sizes.isEmpty ? 'اختر اللون أولاً' : 'اختر المقاس'),
                onChanged: (value) {
                  setState(() {
                    selectedSize = value;
                  });
                },
              ),
            ),

            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: width * (16 / 390)),
            //   child: const Divider(color: Color(0xffF8F8F8), thickness: 1),
            // ),
            SizedBox(height: height * (16 / 844)),

            Padding(
              padding: EdgeInsets.only(right: width * (16 / 390)),
              child: const Text(
                'الكمية',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: height * (16 / 844)),

            Padding(
              padding: EdgeInsets.only(right: width * (16 / 390)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: height * 35 / 844,
                    decoration: BoxDecoration(
                      color: const Color(0xffF3F5F6),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        width: 1,
                        color: const Color.fromARGB(255, 214, 214, 214),
                      ),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: _decrementQuantity,
                          icon: const Icon(
                            Icons.remove,
                            size: 14,
                            color: Color(0xff55585B),
                          ),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(
                            minWidth: 28,
                            minHeight: 28,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: width * 0.016,
                          ),
                          decoration: const BoxDecoration(
                            border: Border.symmetric(
                              vertical: BorderSide(color: Color(0xffF3F5F6)),
                            ),
                          ),
                          child: Text(
                            '$quantity',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff55585B),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: _incrementQuantity,
                          icon: const Icon(
                            Icons.add,
                            size: 14,
                            color: Color(0xff55585B),
                          ),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(
                            minWidth: 28,
                            minHeight: 28,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  if (widget.product.quantity > 0)
                    Text(
                      'متوفر: ${widget.product.quantity}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xff55585B),
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(height: height * (16 / 844)),

            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: width * (16 / 390)),
            //   child: const Divider(color: Color(0xffF8F8F8), thickness: 1),
            // ),
            SizedBox(height: height * (16 / 844)),
          ],
        ),
      ),
      bottomNavigationBar: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          final isLoading = state is CartLoading;

          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: Offset(0, -3),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * (12 / 390),
                vertical: height * (12 / 844),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DefaultButton(
                    text: isLoading ? 'جاري الإضافة...' : 'أضف إلى السلة',
                    onTap:
                        widget.product.isInStock &&
                                !isLoading &&
                                _hasSelectedRequiredOptions
                            ? _addToCart
                            : () {},
                  ),
                  SizedBox(height: height * (20 / 844)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
