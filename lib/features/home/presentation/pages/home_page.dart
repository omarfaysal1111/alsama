import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../products/presentation/bloc/products_bloc.dart';
import '../../../products/presentation/bloc/products_event.dart';
import '../../../products/presentation/bloc/products_state.dart';
import '../../../products/domain/entities/product.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    print('HomePage: initState called, dispatching GetProductsRequested');
    context.read<ProductsBloc>().add(GetProductsRequested());
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'السماء',
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
          onPressed: () {},
          icon: const Icon(Icons.format_align_left_outlined),
          color: Colors.black,
          iconSize: 24.0,
        ),
        actions: [
          GestureDetector(
            onTap: (){},
            child: Padding(
              padding:  EdgeInsets.only(right: width*(16.0/390)),
              child: SizedBox(
                width: 24,
                height: 24,
                child: Image.asset('assets/images/shopping-bag.png')),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.black),
            onPressed: () {
              print('HomePage: Manual refresh triggered');
              context.read<ProductsBloc>().add(GetProductsRequested());
            },
          ),
        ],
      ),
      body: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (context, state) {
          if (state is ProductsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ProductsError) {
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
                      context.read<ProductsBloc>().add(GetProductsRequested());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is ProductsEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.inventory_2_outlined,
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

          if (state is ProductsLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<ProductsBloc>().add(RefreshProductsRequested());
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextField(
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

                        fillColor: Color(0xffF8F8F8),
// border: OutlineInputBorder(
//   borderRadius: BorderRadius.all(Radius.zero),
//   borderSide: BorderSide(color: Color(0xffE0E2E3,), width: 0.5)
// ),
 enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(0)),
      borderSide: BorderSide(color: const Color(0xffE0E2E3,), width: 1),
    ),
      
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(0)),
      borderSide: BorderSide(color:  Color(0xff821F40), width: 1),
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

                    Padding(
                      padding: EdgeInsets.only(
                        top: height * 0.02,
                        bottom: height * 0.02,
                      ),
                      child: Text(
                        textAlign: TextAlign.right,
                        'الأقسام',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 80,
                      child: ListView.separated(
                            scrollDirection: Axis.horizontal, 
                             reverse: true,

                        separatorBuilder:
                            (context, index) => SizedBox(width: width*0.04),
                        itemCount: 3,
                        itemBuilder: (context, index) {
                           List<String> categories = [ "عباية", "ادناء", "فستان"];
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: (){},
                                child: Container(
                                  
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                       
                                    color: Color(0xffF3F5F6),
                                    border: Border.all(color: Color(0xffE0E2E3))
                                  ),
                                  child: SizedBox(
                                    width: 40,
                                    height: 40,
                                    child: Image.asset('assets/images/fashion.png')),
                                  
                                ),
                              ),
                              Padding(
                                padding:  EdgeInsets.only(top: height*0.002),
                                child: Text(categories[index],
                                style: TextStyle(
                                  color:Color(0xff55585B),
                                  fontWeight:FontWeight.w400 ,
                                  fontSize: 12
                                ),
                                ),
                              )
                              
                            ],
                          );
                        },
                      ),
                    ),

                    // Products Grid
                    Expanded(
                      child: GridView.builder(
                        padding:  EdgeInsets.only(top: height*0.02),
                        gridDelegate:
                             SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.66,
                              crossAxisSpacing: height*0.02,
                              mainAxisSpacing: width*0.04,
                            ),
                        itemCount: state.products.length,
                        itemBuilder: (context, index) {
                          final product = state.products[index];
                          return ProductCard(product: product);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return const Center(child: Text('Unknown state'));
        },
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
   double height= MediaQuery.of(context).size.height;
      double width= MediaQuery.of(context).size.width;

    return Card(
      elevation: 0,
      color: Color(0xffF8F8F8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          Expanded(
            flex: 3,
            child: Stack(
              children: [
                Container(
                  
                  
                  width: double.infinity,
                  decoration: BoxDecoration(
                    
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(0),
                    ),
                    color: Color(0xffF3F5F6),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(0),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: product.img,
                      fit: BoxFit.cover,
                      placeholder:
                          (context, url) => Container(
                            color: Color(0xffF3F5F6),
                            child: const Center(child: CircularProgressIndicator()),
                          ),
                      errorWidget:
                          (context, url, error) => Container(
                            color: Colors.grey[200],
                            child: const Icon(
                              Icons.image_not_supported,
                              color: Colors.grey,
                              size: 40,
                            ),
                          ),
                    ),
                  ),
                ),



                Positioned(
        top: height*0.012,
        left: width*0.022,
        child: InkWell(
          onTap: () {
          },
          child: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Icon(
              Icons.favorite_border,
              color: Color(0xff821F40),
              size: 22,
            ),
          ),
        )),
              ],
            ),
          ),

          // Product Details
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Product Title
                  Text(
                    textDirection: TextDirection.rtl,
                    product.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 4),

                  // Price
                  Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                    
                    children: [
                      Text(
                        
                        '${product.price.toStringAsFixed(0)} SAR',
                        style: TextStyle(
                          color: Color(0xff821F40),
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      if (product.hasDiscount) ...[
                        const SizedBox(width: 8),
                        Text(
                          '${product.finalPrice.toStringAsFixed(0)} SAR',
                          style: const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ],
                  ),

                  const Spacer(),

                  // Add to Cart Button
                  // SizedBox(
                  //   width: double.infinity,
                  //   child: ElevatedButton(
                  //     onPressed: () {
                  //       // TODO: Add to cart functionality
                  //       ScaffoldMessenger.of(context).showSnackBar(
                  //         SnackBar(
                  //           content: Text('${product.title} added to cart'),
                  //           duration: const Duration(seconds: 2),
                  //         ),
                  //       );
                  //     },
                  //     style: ElevatedButton.styleFrom(
                  //       backgroundColor: Colors.blue,
                  //       foregroundColor: Colors.white,
                  //       padding: const EdgeInsets.symmetric(vertical: 8),
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(8),
                  //       ),
                  //     ),
                  //     child: const Text(
                  //       'Add to Cart',
                  //       style: TextStyle(fontSize: 12),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
