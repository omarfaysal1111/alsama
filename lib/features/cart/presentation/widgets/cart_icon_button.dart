import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/routes/app_routes.dart';
import '../bloc/cart_bloc.dart';
import '../bloc/cart_state.dart';

class CartIconButton extends StatefulWidget {
  const CartIconButton({super.key, this.margin});

  final EdgeInsetsGeometry? margin;

  @override
  State<CartIconButton> createState() => _CartIconButtonState();
}

class _CartIconButtonState extends State<CartIconButton> {
  int _badgeCount = 0;

  @override
  void initState() {
    super.initState();
    _badgeCount = _extractCount(context.read<CartBloc>().state) ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return BlocListener<CartBloc, CartState>(
      listener: (context, state) {
        final count = _extractCount(state);
        if (count != null && count != _badgeCount) {
          setState(() {
            _badgeCount = count;
          });
        }
      },
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, AppRoutes.cart),
        child: Container(
          margin: widget.margin ?? EdgeInsets.only(right: width * (16 / 390)),
          width: 24,
          height: 24,
          alignment: Alignment.center,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Image.asset('assets/images/shopping-bag.png'),
              if (_badgeCount > 0)
                Positioned(
                  right: -width * (4 / 390),
                  top: -height * (2 / 844),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 2,
                    ),
                    decoration: const BoxDecoration(
                      color: Color(0xff821F40),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Text(
                      _badgeCount > 99 ? '99+' : '$_badgeCount',
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  int? _extractCount(CartState state) {
    if (state is CartLoaded) {
      return state.itemsCount;
    }
    if (state is CartItemsCountLoaded) {
      return state.count;
    }
    if (state is CartEmpty) {
      return 0;
    }
    return null;
  }
}
