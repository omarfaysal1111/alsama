import 'package:alsama/features/auth/presentation/widgets/default_button.dart';
import 'package:alsama/features/cart/presentation/widgets/cart_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/routes/app_routes.dart';
import '../bloc/cart_bloc.dart';
import '../bloc/cart_event.dart';
import '../bloc/cart_state.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
    // Use WidgetsBinding to ensure context is ready
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<CartBloc>().add(GetCartRequested());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'السلة',
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
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.black,
          iconSize: 24.0,
        ),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is CartError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
                  const SizedBox(height: 16),
                  Text(
                    'Error: ${state.message}',
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<CartBloc>().add(GetCartRequested());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is CartEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    state.message,
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          if (state is CartLoaded) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.04),
              child: Column(
                children: [
                  Expanded(
                    flex: 3,
                    child: ListView.builder(
                      itemCount: state.cartItems.length,
                      itemBuilder: (context, index) {
                        final cartItem = state.cartItems[index];
                        return CartItemCard(
                          cartItemId: cartItem.id,
                          productName: cartItem.product.title,
                          price: cartItem.totalPrice.toStringAsFixed(2),
                          quantity: cartItem.quantity,
                          image: cartItem.product.img,
                          size:
                              null, // You can add size if available in product
                          color:
                              null, // You can add color if available in product
                          onIncrease: () {
                            context.read<CartBloc>().add(
                              UpdateCartItemQuantityRequested(
                                cartItemId: cartItem.id,
                                quantity: cartItem.quantity + 1,
                              ),
                            );
                          },
                          onDecrease: () {
                            if (cartItem.quantity > 1) {
                              context.read<CartBloc>().add(
                                UpdateCartItemQuantityRequested(
                                  cartItemId: cartItem.id,
                                  quantity: cartItem.quantity - 1,
                                ),
                              );
                            }
                          },
                          onDelete: () {
                            context.read<CartBloc>().add(
                              RemoveFromCartRequested(cartItemId: cartItem.id),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: BorderDirectional(
                        top: BorderSide(color: Color(0xffF8F8F8)),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                'اجمالي السعر',
                                textAlign: TextAlign.right,
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                  color: Color(0xff55585B),
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                ' ${state.total.toStringAsFixed(2)} ج.م',
                                textAlign: TextAlign.right,
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                  color: Color(0xff821F40),
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 230,
                            height: 54,
                            child: DefaultButton(
                              text: 'متابعة الدفع',
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  '/enhanced-checkout',
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                ],
              ),
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
