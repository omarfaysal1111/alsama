import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../auth/presentation/widgets/default_button.dart';
import '../../../orders/domain/entities/order.dart';
import '../../../orders/presentation/bloc/orders_bloc.dart';
import '../../../orders/presentation/bloc/orders_event.dart';
import '../../../orders/presentation/bloc/orders_state.dart';
import '../bloc/cart_bloc.dart';
import '../bloc/cart_event.dart';
import '../bloc/cart_state.dart';
import '../widgets/address_form_widget.dart';
import '../widgets/payment_method_selector.dart';

class EnhancedCheckoutPage extends StatefulWidget {
  const EnhancedCheckoutPage({super.key});

  @override
  State<EnhancedCheckoutPage> createState() => _EnhancedCheckoutPageState();
}

class _EnhancedCheckoutPageState extends State<EnhancedCheckoutPage> {
  Map<String, String>? _shippingAddress;
  PaymentMethod _paymentMethod = PaymentMethod.cashOnDelivery;
  final double _shippingCost = 40.0;
  final double _taxRate = 0.14; // 14% tax

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<CartBloc>().add(GetCartRequested());
      }
    });
  }

  void _onAddressChanged(Map<String, String> address) {
    setState(() {
      _shippingAddress = address;
    });
  }

  void _onPaymentMethodChanged(PaymentMethod method) {
    setState(() {
      _paymentMethod = method;
    });
  }

  void _completeOrder(CartLoaded cartState) {
    if (_shippingAddress == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('الرجاء إكمال بيانات العنوان'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Calculate totals
    final subtotal = cartState.total;
    final tax = subtotal * _taxRate;
    final total = subtotal + _shippingCost + tax;

    // Create order data
    final orderData = {
      'userId': 'user_285_2', // TODO: Get from auth state
      'items': cartState.cartItems.map((item) {
        return {
          'id': const Uuid().v4(),
          'productId': item.product.id,
          'productTitle': item.product.title,
          'productImage': item.product.img,
          'price': item.product.price,
          'discount': item.product.discount,
          'quantity': item.quantity,
        };
      }).toList(),
      'subtotal': subtotal,
      'discount': 0.0,
      'shipping': _shippingCost,
      'tax': tax,
      'total': total,
      'status': 'pending',
      'paymentMethod': _paymentMethodToString(_paymentMethod),
      'paymentStatus': 'pending',
      'shippingAddress': _shippingAddress,
      'createdAt': DateTime.now().toIso8601String(),
    };

    // Dispatch create order event
    context.read<OrdersBloc>().add(CreateOrderRequested(orderData: orderData));
  }

  String _paymentMethodToString(PaymentMethod method) {
    return method.toString().split('.').last;
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'إتمام الطلب',
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
      body: MultiBlocListener(
        listeners: [
          BlocListener<OrdersBloc, OrdersState>(
            listener: (context, state) {
              if (state is OrderCreated) {
                // Clear cart
                context.read<CartBloc>().add(ClearCartRequested());
                
                // Show success message
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('تم إنشاء الطلب بنجاح'),
                    backgroundColor: Colors.green,
                  ),
                );

                // Navigate to order details or orders list
                Navigator.pop(context);
              } else if (state is OrdersError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
          ),
        ],
        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, cartState) {
            if (cartState is CartLoading || cartState is CartInitial) {
              return const Center(child: CircularProgressIndicator());
            }

            if (cartState is CartError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
                    const SizedBox(height: 16),
                    Text(cartState.message, textAlign: TextAlign.center),
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

            if (cartState is CartEmpty) {
              return const Center(child: Text('لا توجد عناصر في السلة للمتابعة'));
            }

            if (cartState is CartLoaded) {
              final subtotal = cartState.total;
              final tax = subtotal * _taxRate;
              final total = subtotal + _shippingCost + tax;

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
                      child: AddressFormWidget(
                        onAddressChanged: _onAddressChanged,
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                    _SectionCard(
                      title: 'طريقة الدفع',
                      child: PaymentMethodSelector(
                        onPaymentMethodChanged: _onPaymentMethodChanged,
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                    _SectionCard(
                      title: 'ملخص الطلب',
                      child: Column(
                        children: List.generate(cartState.cartItems.length, (index) {
                          final item = cartState.cartItems[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
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
                                  '${item.totalPrice.toStringAsFixed(2)} ج.م',
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
                            value: '${subtotal.toStringAsFixed(2)} ج.م',
                          ),
                          const SizedBox(height: 6),
                          _SummaryRow(
                            label: 'رسوم الشحن',
                            value: '${_shippingCost.toStringAsFixed(2)} ج.م',
                          ),
                          const SizedBox(height: 6),
                          _SummaryRow(
                            label: 'الضريبة (14%)',
                            value: '${tax.toStringAsFixed(2)} ج.م',
                          ),
                          const Divider(height: 24),
                          _SummaryRow(
                            label: 'المجموع النهائي',
                            value: '${total.toStringAsFixed(2)} ج.م',
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
      ),
      bottomNavigationBar: BlocBuilder<CartBloc, CartState>(
        builder: (context, cartState) {
          return BlocBuilder<OrdersBloc, OrdersState>(
            builder: (context, ordersState) {
              final isLoading = ordersState is OrdersLoading;
              
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.04,
                  vertical: height * 0.02,
                ),
                child: DefaultButton(
                  text: isLoading ? 'جاري المعالجة...' : 'إتمام الطلب',
                  onTap: isLoading || cartState is! CartLoaded
                      ? () {}
                      : () => _completeOrder(cartState as CartLoaded),
                ),
              );
            },
          );
        },
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
        crossAxisAlignment: CrossAxisAlignment.end,
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
