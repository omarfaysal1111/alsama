import 'package:alsama/features/home/presentation/pages/menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../bloc/categories_bloc.dart';
import '../bloc/categories_event.dart';
import '../bloc/categories_state.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../cart/presentation/widgets/cart_icon_button.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  @override
  void initState() {
    super.initState();
    // Use WidgetsBinding to ensure context is ready
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<CategoriesBloc>().add(GetCategoriesRequested());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'الأقسام',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
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
        centerTitle: true,
        surfaceTintColor: Colors.white,
        foregroundColor: Colors.white,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: BlocBuilder<CategoriesBloc, CategoriesState>(
        builder: (context, state) {
          if (state is CategoriesLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is CategoriesError) {
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
                      context.read<CategoriesBloc>().add(
                        GetCategoriesRequested(),
                      );
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is CategoriesEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.category_outlined,
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

          if (state is CategoriesLoaded) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.04),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.categories.length,
                      padding: EdgeInsets.all(0),
                      itemBuilder: (context, index) {
                        final category = state.categories[index];
                        return GestureDetector(
                          onTap: () {
                            final filterValue =
                                category.parent.trim().toLowerCase();
                            Navigator.pushNamed(
                              context,
                              AppRoutes.products,
                              arguments: {
                                'category': filterValue,
                                'categoryLabel': category.parent,
                              },
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.only(bottom: height * 0.016),
                            height: height * 80 / 844,
                            decoration: BoxDecoration(
                              color: Color(0xfff8f8f8),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: width * 0.04,
                                    ),
                                    child: Text(
                                      category.parent,
                                      textAlign: TextAlign.right,
                                      textDirection: TextDirection.rtl,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                ClipRRect(
                                  child: CachedNetworkImage(
                                    imageUrl: category.img,
                                    width: 80,
                                    
                                    height: double.infinity,
                                    fit: BoxFit.contain,
                                    placeholder:
                                        (context, url) => Container(
                                          width: 80,
                                          
                                          height: double.infinity,
                                          color: Color(0xffF8F8F8),
                                          child: const Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                        ),
                                    errorWidget:
                                        (context, url, error) => Container(
                                          width: 80,
                                          height: double.infinity,
                                          color: Colors.grey[300],
                                          child: const Icon(Icons.error),
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
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
