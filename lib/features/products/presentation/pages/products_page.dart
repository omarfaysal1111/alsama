import 'package:alsama/features/home/presentation/pages/menu_widget.dart';
import 'package:alsama/features/products/presentation/widgets/filter_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/products_bloc.dart';
import '../bloc/products_event.dart';
import '../bloc/products_state.dart';
import '../../domain/entities/product.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../cart/presentation/widgets/cart_icon_button.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key, required category, required categoryLabel});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  String? _categoryFilter;
  String? _categoryLabel;

  @override
  void initState() {
    super.initState();
    // Get category from route arguments after frame is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final args = ModalRoute.of(context)?.settings.arguments;
        String? categoryValue;
        String? categoryLabel;

        if (args is Map<String, dynamic>) {
          categoryValue = args['category'] as String?;
          categoryLabel = args['categoryLabel'] as String?;
        }

        final normalizedCategory = categoryValue?.trim().toLowerCase();

        setState(() {
          _categoryFilter = normalizedCategory;
          _categoryLabel = categoryLabel ?? categoryValue;
        });

        // Load products with category filter
        context.read<ProductsBloc>().add(
          GetProductsRequested(category: normalizedCategory),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _categoryLabel ?? 'المنتجات',
          style: const TextStyle(
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

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * (16 / 390)),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: width * (290 / 390),
                  height: height * (49 / 844),
                  child: TextField(
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                      hintText: '...ابحث هنا',
                      hintStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xffADAFB1),
                      ),
                      suffixIcon: const Icon(
                        Icons.search,
                        size: 24,
                        color: Color(0xff55585B),
                      ),
                      filled: true,
                      fillColor: const Color(0xffF8F8F8),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(0)),
                        borderSide: BorderSide(
                          color: Color(0xffE0E2E3),
                          width: 1,
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(0)),
                        borderSide: BorderSide(
                          color: Color(0xff821F40),
                          width: 1,
                        ),
                      ),
                    ),
                    onSubmitted: (query) {
                      if (query.isNotEmpty) {
                        context.read<ProductsBloc>().add(
                          SearchProductsRequested(query: query),
                        );
                      }
                    },
                  ),
                ),

                GestureDetector(
                  onTap: () {
                    showGeneralDialog(
                      context: context,
                      barrierDismissible: true,
                      barrierLabel: 'فلتر المنتجات',
                      barrierColor: Colors.black.withOpacity(0.4),
                      transitionDuration: const Duration(milliseconds: 400),
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return Align(
                          alignment: Alignment.centerRight,
                          child: FilterWidget(),
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

                        return SlideTransition(
                          position: offsetAnimation,
                          child: child,
                        );
                      },
                    );
                  },
                  child: Container(
                    width: width * (51 / 390),
                    height: height * (49 / 844),
                    decoration: BoxDecoration(
                      color: const Color(0xffF8F8F8),
                      border: Border.all(color: const Color(0xffE0E2E3)),
                    ),
                    child: Center(
                      child: Image.asset(
                        'assets/images/Filter.png',
                        width: width * (24 / 390),
                        height: height * (24 / 844),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: height * 0.02),
            Expanded(
              child: BlocBuilder<ProductsBloc, ProductsState>(
                builder: (context, state) {
                  if (state is ProductsLoading || state is ProductsInitial) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is ProductsError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 64,
                            color: Colors.red[300],
                          ),
                          const SizedBox(height: 16),
                          Text(state.message, textAlign: TextAlign.center),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              context.read<ProductsBloc>().add(
                                GetProductsRequested(category: _categoryFilter),
                              );
                            },
                            child: const Text('إعادة المحاولة'),
                          ),
                        ],
                      ),
                    );
                  }

                  if (state is ProductsEmpty) {
                    return Center(
                      child: Text(
                        state.message,
                        style: const TextStyle(fontSize: 16),
                      ),
                    );
                  }

                  if (state is ProductsLoaded) {
                    return RefreshIndicator(
                      onRefresh: () async {
                        context.read<ProductsBloc>().add(
                          GetProductsRequested(category: _categoryFilter),
                        );
                      },
                      child: GridView.builder(
                        padding: EdgeInsets.only(top: height * 0.01),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.65,
                          crossAxisSpacing: width * 0.04,
                          mainAxisSpacing: height * 0.02,
                        ),
                        itemCount: state.products.length,
                        itemBuilder: (context, index) {
                          final product = state.products[index];
                          return _ProductGridCard(product: product);
                        },
                      ),
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductGridCard extends StatelessWidget {
  const _ProductGridCard({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRoutes.productDetail,
          arguments: product,
        );
      },
      child: Card(
        elevation: 0,
        color: const Color(0xffF8F8F8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                color: const Color(0xffF3F5F6),
                child: ClipRRect(
                  //  borderRadius: BorderRadiusGeometry.circular(8),
                  child: Image.network(
                    product.img,
                    fit: BoxFit.cover,
                    errorBuilder:
                        (context, error, stackTrace) => const Icon(
                          Icons.image_not_supported,
                          color: Colors.grey,
                          size: 40,
                        ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.all(width * 0.03),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      product.title,
                      textDirection: TextDirection.rtl,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: height * 0.01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          '${product.finalPrice.toStringAsFixed(0)} ج.م',
                          style: const TextStyle(
                            color: Color(0xff821F40),
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        if (product.hasDiscount) ...[
                          const SizedBox(width: 6),
                          Text(
                            '${product.price.toStringAsFixed(0)} ج.م',
                            style: const TextStyle(
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
