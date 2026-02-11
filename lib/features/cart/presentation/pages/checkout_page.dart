import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/presentation/widgets/default_button.dart';
import '../bloc/cart_bloc.dart';
import '../bloc/cart_event.dart';
import '../bloc/cart_state.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<CartBloc>().add(GetCartRequested());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'الدفع',
          style: TextStyle(
            fontFamily: 'Cairo',
            fontWeight: FontWeight.w500,
            color: Colors.black,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.black,
          iconSize: 24.0,
        ),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoading || state is CartInitial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is CartError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
                  const SizedBox(height: 16),
                  Text(state.message, textAlign: TextAlign.center),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed:
                        () => context.read<CartBloc>().add(GetCartRequested()),
                    child: const Text('إعادة المحاولة'),
                  ),
                ],
              ),
            );
          }

          if (state is CartEmpty) {
            return const Center(child: Text('لا توجد عناصر في السلة للمتابعة'));
          }

          if (state is CartLoaded) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.04,
                vertical: height * 0.02,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _SectionCard(
                    title: 'معلومات التوصيل',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: const [
                        Text('الاسم: اسم العميل', textAlign: TextAlign.right),
                        SizedBox(height: 4),
                        Text(
                          'العنوان: القاهرة، مصر',
                          textAlign: TextAlign.right,
                        ),
                        SizedBox(height: 4),
                        Text(
                          'رقم الهاتف: 01234567890',
                          textAlign: TextAlign.right,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  _SectionCard(
                    title: 'طريقة الدفع',
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'الدفع عند الاستلام',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Icon(Icons.keyboard_arrow_down),
                      ],
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  _SectionCard(
                    title: 'ملخص الطلب',
                    child: Column(
                      children: List.generate(state.cartItems.length, (index) {
                        final item = state.cartItems[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: CachedNetworkImage(
                                  imageUrl: item.product.img,
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                  placeholder:
                                      (context, url) => Container(
                                        color: const Color(0xffF3F5F6),
                                      ),
                                  errorWidget:
                                      (context, url, error) =>
                                          const Icon(Icons.image_not_supported),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      item.product.title,
                                      textAlign: TextAlign.right,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'الكمية: ${item.quantity}',
                                      textAlign: TextAlign.right,
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                '${item.totalPrice.toStringAsFixed(2)} EGP',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff821F40),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  _SectionCard(
                    title: 'التكلفة الإجمالية',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _SummaryRow(
                          label: 'إجمالي المنتجات',
                          value:
                              '${state.cartItems.fold<double>(0, (sum, item) => sum + item.totalPrice).toStringAsFixed(2)} EGP',
                        ),
                        const SizedBox(height: 6),
                        const _SummaryRow(
                          label: 'رسوم الشحن',
                          value: '40.00 EGP',
                        ),
                        const Divider(height: 24),
                        _SummaryRow(
                          label: 'المجموع النهائي',
                          value: '${(state.total + 40).toStringAsFixed(2)} EGP',
                          isBold: true,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: height * 0.12),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.04,
          vertical: height * 0.02,
        ),
        child: DefaultButton(text: 'إتمام الدفع', onTap: () {}),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xffF8F8F8),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xffE0E2E3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.label,
    required this.value,
    this.isBold = false,
  });

  final String label;
  final String value;
  final bool isBold;

  @override
  Widget build(BuildContext context) {
    final TextStyle baseStyle = TextStyle(
      fontSize: 14,
      fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
      color: isBold ? const Color(0xff821F40) : const Color(0xff55585B),
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(value, style: baseStyle),
        Text(label, style: baseStyle.copyWith(color: Colors.black)),
      ],
    );
  }
}
