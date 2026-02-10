import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CartItemCard extends StatelessWidget {
  final String cartItemId;
  final String productName;
  final String price;
  final String? size;
  final String? color;
  final String image;
  final int quantity;
  final VoidCallback? onIncrease;
  final VoidCallback? onDecrease;
  final VoidCallback? onDelete;

  const CartItemCard({
    super.key,
    required this.cartItemId,
    required this.productName,
    required this.price,
    this.size,
    this.color,
    required this.image,
    required this.quantity,
    this.onIncrease,
    this.onDecrease,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Stack(
        children: [
          Card(
            shape: RoundedRectangleBorder(),
            elevation: 0,
            margin: EdgeInsets.symmetric(
              vertical: height * 9 / 844,
            ),
            color: const Color(0xffF3F5F6),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.04,
                vertical: height * 0.02,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: width * 81 / 390,
                    height: height * 81 / 844,
                    decoration: BoxDecoration(color: const Color(0xffF8F8F8)),
                    child: image.startsWith('http')
                        ? CachedNetworkImage(
                            imageUrl: image,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(
                              color: Colors.grey[300],
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                            errorWidget: (context, url, error) => Container(
                              color: Colors.grey[300],
                              child: const Icon(Icons.error),
                            ),
                          )
                        : Image.asset(image, fit: BoxFit.cover),
                  ),

                  SizedBox(width: width * 0.05),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          productName,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        SizedBox(height: height * 0.016),

                        Text(
                          '$price ج.م',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: height * 0.02),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (size != null && size!.isNotEmpty)
                                    Text(
                                      'المقاس: $size',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Color(0xff55585B),
                                      ),
                                      overflow: TextOverflow.visible,
                                    ),
                                  if (size != null && size!.isNotEmpty)
                                    SizedBox(height: height * 0.016),
                                  if (color != null && color!.isNotEmpty)
                                    Text(
                                      'اللون: $color',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Color(0xff55585B),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            SizedBox(width: width * 0.012),
                            Row(
                              children: [
                                Container(
                                  height: height * 32 / 844,
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 248, 248, 248),
                                    border: Border.all(
                                      width:1 ,
                                        color: Color.fromARGB(255, 214, 214, 214),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      IconButton(
                                        onPressed: onDecrease,
                                        icon: Icon(
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
                                            vertical: BorderSide(
                                              color: Color(0xff55585B),
                                            ),
                                          ),
                                        ),
                                        child: Text(
                                          quantity.toString(),
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: onIncrease,
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
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 20),

                  // Container(
                  //   decoration: BoxDecoration(
                  //     color: Colors.red.withOpacity(0.2),
                  //     shape: BoxShape.circle,
                  //   ),
                  //   child: IconButton(
                  //     onPressed: onDelete,
                  //     icon: const Icon(
                  //       Icons.delete_outline_outlined,
                  //       color: Colors.redAccent,
                  //       size: 24,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),

          Positioned(
            left: 20,
            top: 22,
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
                onPressed: onDelete,
                icon: const Icon(
                  Icons.delete_outline,
                  color: Color(0xffC30909),
                  size: 24,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
