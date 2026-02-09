import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../auth/presentation/widgets/default_button.dart';
import '../../../cart/presentation/bloc/cart_bloc.dart';
import '../../../cart/presentation/bloc/cart_event.dart';
import '../../../cart/presentation/widgets/cart_icon_button.dart';
import '../../domain/entities/product.dart';
// import '../../../../core/routes/app_routes.dart';
import '../widgets/custom_dropdown.dart';
import '../../../wishlist/presentation/cubit/wishlist_cubit.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  String? selectedSize;
  String? selectedColor;
  int quantity = 1;

  final List<String> sizeOptions = ['S', 'M', 'L', 'XL'];
  final List<String> colorOptions = ['أحمر', 'أزرق', 'أسود', 'أبيض'];

  void _incrementQuantity() {
    setState(() {
      quantity += 1;
    });
  }

  void _decrementQuantity() {
    if (quantity == 1) return;
    setState(() {
      quantity -= 1;
    });
  }

  void _handleAddToCart(Product product, BuildContext context) {
    context.read<CartBloc>().add(
      AddProductToCartRequested(product: product, quantity: quantity),
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('تم إضافة ${product.title} إلى السلة'),
        duration: const Duration(seconds: 2),
        backgroundColor: const Color(0xff821F40),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args == null || args is! Product) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('خطأ'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: const Center(child: Text('لم يتم العثور على المنتج')),
      );
    }

    // ignore: unnecessary_cast
    final product = args as Product;
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    final isFavorite = context.select<WishlistCubit, bool>(
      (cubit) => cubit.isFavorite(product.id),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          CartIconButton(margin: EdgeInsets.only(right: width * (16 / 390))),
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: const Color(0xff821F40),
            ),
            onPressed:
                () => context.read<WishlistCubit>().toggleProduct(product),
          ),
        ],
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
                  imageUrl: product.img,
                  fit: BoxFit.cover,
                  placeholder:
                      (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                  errorWidget:
                      (context, url, error) => const Icon(
                        Icons.image_not_supported,
                        size: 40,
                        color: Colors.grey,
                      ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * (16 / 390)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\u202B ${product.finalPrice.toStringAsFixed(0)} ج.م',
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          color: Color(0xff821F40),
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          product.title,
                          textAlign: TextAlign.right,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (product.hasDiscount)
                    Padding(
                      padding: EdgeInsets.only(top: height * (8 / 844)),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          '${product.price.toStringAsFixed(0)} ج.م',
                          style: const TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  SizedBox(height: height * (16 / 844)),
                  const Divider(color: Color(0xffF8F8F8), thickness: 1),
                  SizedBox(height: height * (16 / 844)),
                  SizedBox(
                    height: height * (80 / 844),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 6,
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
                                imageUrl: product.img,
                                fit: BoxFit.cover,
                                errorWidget:
                                    (context, url, error) => const Icon(
                                      Icons.image_not_supported,
                                      color: Colors.grey,
                                    ),
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
                product.description,
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
              padding: EdgeInsets.symmetric(horizontal: width * (16 / 390)),
              child: CustomDropdown(
                width: double.infinity,
                height: 48,
                items: colorOptions,
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
              padding: EdgeInsets.symmetric(horizontal: width * (16 / 390)),
              child: CustomDropdown(
                width: double.infinity,
                height: 48,
                items: sizeOptions,
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
                ],
              ),
            ),
            SizedBox(height: height * (16 / 844)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * (16 / 390)),
              child: const Divider(color: Color(0xffF8F8F8), thickness: 1),
            ),
            SizedBox(height: height * (24 / 844)),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * (16 / 390),
          vertical: height * (20 / 844),
        ),
        child: DefaultButton(
          text: 'أضف إلى السلة',
          onTap: () => _handleAddToCart(product, context),
        ),
      ),
    );
  }
}
