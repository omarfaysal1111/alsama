import 'package:alsama/features/auth/presentation/widgets/default_button.dart';
import 'package:alsama/features/products/presentation/widgets/custom_dropdown.dart';
import 'package:alsama/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:alsama/features/cart/presentation/bloc/cart_event.dart';
import 'package:alsama/features/cart/presentation/bloc/cart_state.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/product.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;
  
  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  String? selectedSize;
  String? selectedColor;
  int quantity = 1;
  
  final List<String> sizes = ['S', 'M', 'L', 'XL', 'XXL'];
  final List<String> colors = ['أحمر', 'أزرق', 'أسود', 'أبيض'];

  void _addToCart() {
    // Create product with selected color and size IDs
    final productWithOptions = widget.product.copyWith(
      colorId: selectedColor != null ? _getColorId(selectedColor!) : '1',
      sizeId: selectedSize != null ? _getSizeId(selectedSize!) : '1',
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
  
  // Helper method to convert color name to ID
  String _getColorId(String colorName) {
    final colorMap = {
      'أحمر': '1',
      'أزرق': '2',
      'أسود': '3',
      'أبيض': '4',
    };
    return colorMap[colorName] ?? '1';
  }
  
  // Helper method to convert size name to ID
  String _getSizeId(String sizeName) {
    final sizeMap = {
      'S': '1',
      'M': '2',
      'L': '3',
      'XL': '4',
      'XXL': '5',
    };
    return sizeMap[sizeName] ?? '3';  // Default to L
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
              child: Container(
                width: double.infinity,
                height: height * (400 / 844),
                decoration: const BoxDecoration(color: Color(0xffF3F5F6)),
                child: CachedNetworkImage(
                  imageUrl: widget.product.img,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(
                    Icons.image_not_supported,
                    size: 80,
                    color: Colors.grey,
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
                            '${widget.product.finalPrice.toStringAsFixed(0)} ج.م',
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              color: Color(0xff821F40),
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (widget.product.hasDiscount)
                            Text(
                              '${widget.product.price.toStringAsFixed(0)} ج.م',
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
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height * (16 / 844)),
                  const Divider(color: Color(0xffF8F8F8), thickness: 1),

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
                              child: Container(
                                width: width * (60 / 390),
                                decoration: const BoxDecoration(
                                  color: Color(0xffF3F5F6),
                                ),
                                child: CachedNetworkImage(
                                  imageUrl: widget.product.imageURLs[index].img,
                                  fit: BoxFit.cover,
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.image),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  const Divider(color: Color(0xffF8F8F8), thickness: 1),

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

            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * (16 / 390)),
              child: const Divider(color: Color(0xffF8F8F8), thickness: 1),
            ),

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
                  fontSize: 16,
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
                items: colors,
                selectedValue: selectedColor,
                hintText: 'اختر اللون',
                onChanged: (value) {
                  setState(() {
                    selectedColor = value;
                  });
                },
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * (16 / 390)),
              child: const Divider(color: Color(0xffF8F8F8), thickness: 1),
            ),

            SizedBox(height: height * (16 / 844)),

            Padding(
              padding: EdgeInsets.only(right: width * (16 / 390)),
              child: const Text(
                'المقاس',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
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
                items: sizes,
                selectedValue: selectedSize,
                hintText: 'اختر المقاس',
                onChanged: (value) {
                  setState(() {
                    selectedSize = value;
                  });
                },
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * (16 / 390)),
              child: const Divider(color: Color(0xffF8F8F8), thickness: 1),
            ),

            SizedBox(height: height * (16 / 844)),

            Padding(
              padding: EdgeInsets.only(right: width * (16 / 390)),
              child: const Text(
                'الكمية',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
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

            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * (16 / 390)),
              child: const Divider(color: Color(0xffF8F8F8), thickness: 1),
            ),

            SizedBox(height: height * (16 / 844)),
          ],
        ),
      ),
      bottomNavigationBar: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          final isLoading = state is CartLoading;
          
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: width * (16 / 390)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DefaultButton(
                  text: isLoading ? 'جاري الإضافة...' : 'أضف إلى السلة',
                  onTap: widget.product.isInStock && !isLoading
                      ? _addToCart
                      : () {},
                ),
                SizedBox(height: height * (20 / 844)),
              ],
            ),
          );
        },
      ),
    );
  }
}
