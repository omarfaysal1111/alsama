import 'package:alsama/features/home/presentation/pages/menu_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/routes/app_routes.dart';
import '../../../products/presentation/bloc/products_bloc.dart';
import '../../../products/presentation/bloc/products_state.dart';
import '../../../wishlist/domain/entities/wishlist_item.dart';
import '../../../wishlist/presentation/cubit/wishlist_cubit.dart';
import '../../../cart/presentation/widgets/cart_icon_button.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'المفضلة',
          style: TextStyle(
            fontFamily: 'Cairo',
            fontWeight: FontWeight.w500,
            color: Colors.black,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        surfaceTintColor: Colors.white,
        foregroundColor: Colors.white,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            showGeneralDialog(
              context: context,
              barrierDismissible: true,
              barrierLabel: "إغلاق",
              barrierColor: Colors.black.withOpacity(0.3),
              pageBuilder: (context, animation, secondaryAnimation) {
                return Align(
                  alignment: Alignment.centerLeft,
                  child: MenuWidget(),
                );
              },
              transitionBuilder: (
                context,
                animation,
                secondaryAnimation,
                child,
              ) {
                final offsetAnimation = Tween<Offset>(
                  begin: const Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeOutCubic,
                  ),
                );

                return SlideTransition(position: offsetAnimation, child: child);
              },
            );
          },
          icon: Icon(Icons.format_align_left),
          color: Colors.black,
        ),
        actions: [
          CartIconButton(margin: EdgeInsets.only(right: width * (16 / 390))),
        ],
      ),
      body: BlocBuilder<WishlistCubit, WishlistState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.items.isEmpty) {
            return const _EmptyWishlistView();
          }

          return ListView.separated(
            padding: EdgeInsets.symmetric(
              horizontal: width * (16 / 390),
              vertical: height * (16 / 844),
            ),
            itemBuilder: (context, index) {
              final item = state.items[index];
              return _WishlistItemCard(item: item);
            },
            separatorBuilder: (_, __) => SizedBox(height: height * (12 / 844)),
            itemCount: state.items.length,
          );
        },
      ),
    );
  }
}

class _WishlistItemCard extends StatelessWidget {
  const _WishlistItemCard({required this.item});

  final WishlistItem item;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () => _openProductDetail(context, item),
      child: Container(

       // padding: EdgeInsets.all(width * (16 / 390)),
        decoration: BoxDecoration(
          color: const Color(0xffF8F8F8),
          border: Border.all(color: const Color(0xffE0E2E3),width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16.0,left: 16),
              child: Container(
               decoration: BoxDecoration(
    color: Colors.red.withOpacity(0.2), 
    shape: BoxShape.circle,
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1), 
        blurRadius: 4,
        offset: Offset(0, 2),
      ),
    ],
  ),
                child: IconButton(
                  onPressed:
                      () => context.read<WishlistCubit>().removeById(item.id),
                  icon: const Icon(
                    Icons.delete_outline,
                    color: Color(0xffC30909),
                    size: 20,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12,),
            Expanded(
              child: Padding(
              padding: const EdgeInsets.only(top: 12.0,),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      item.title,
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: height * (4 / 844)),
                    Text(
                      item.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xff55585B),
                      ),
                    ),
                    SizedBox(height: height * (12 / 844)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Directionality(
                          textDirection: TextDirection.rtl,
                
                          child: Text(
                            '${item.finalPrice.toStringAsFixed(0)} ج.م ',
                            style: const TextStyle(
                              color: Color(0xff821F40),
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        if (item.hasDiscount) ...[
                          const SizedBox(width: 8),
                          Text(
                            '${item.price.toStringAsFixed(0)} ج.م',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: width * (12 / 390)),

            ClipRRect(
                  borderRadius: BorderRadius.circular(8),

              child: Container(
                width: width * (100 / 390),
                height: height * (140 / 844),
                decoration: BoxDecoration(
                                  color: const Color(0xffF3F5F6),
borderRadius: BorderRadius.circular(8)
                ),
                child: CachedNetworkImage(
                  imageUrl: item.img,
                  fit: BoxFit.cover,
                  placeholder:
                      (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                  errorWidget:
                      (context, url, error) => const Icon(
                        Icons.image_not_supported,
                        color: Colors.grey,
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openProductDetail(BuildContext context, WishlistItem item) {
    final productsState = context.read<ProductsBloc>().state;
    if (productsState is ProductsLoaded) {
      try {
        final product = productsState.products.firstWhere(
          (product) => product.id == item.id,
        );
        Navigator.pushNamed(
          context,
          AppRoutes.productDetail,
          arguments: product,
        );
        return;
      } catch (_) {
        // Continue to snackbar below
      }
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('المنتج غير متاح حالياً، يرجى تحديث قائمة المنتجات'),
      ),
    );
  }
}

class _EmptyWishlistView extends StatelessWidget {
  const _EmptyWishlistView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.favorite_border, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'قائمة المفضلة فارغة',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'أضف منتجاتك المفضلة من صفحة الرئيسية',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
