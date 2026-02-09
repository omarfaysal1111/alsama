
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class BannerSlider extends StatefulWidget {
  @override
  _BannerSliderState createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSlider> {
  final CarouselSliderController _controller = CarouselSliderController();

  final List<String> imgList = [
    'assets/images/im1.jpeg',
    'assets/images/im2.jpeg',
    'assets/images/im3.jpeg',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xffF8F8F8)
      ),
      
      child: Stack(
        children: [
          CarouselSlider(
            carouselController: _controller,
            options: CarouselOptions(
              height: 190.0,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              viewportFraction: 1.0,
              enlargeCenterPage: false,
            ),
            items: imgList.map((item) => Container(
              width: 190,
              height: 120,
            
              child: Image.asset(
                item,
                fit: BoxFit.fill,
                width: double.infinity,
              ),
            )).toList(),
          ),

          Positioned(
            left: 10,
            top: 0,
            bottom: 0,
            child: Center(
              child: IconButton(
                padding: const EdgeInsets.only(left: 6.0), // زقيناها يمين شوية (بإضافة مسافة من الشمال)
                onPressed: () => _controller.previousPage(),
                icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 24),
                style: IconButton.styleFrom(backgroundColor: Colors.black26),
              ),
            ),
          ),

          Positioned(
            right: 10,
            top: 0,
            bottom: 0,
            child: Center(
              child: IconButton(
                onPressed: () => _controller.nextPage(),
                icon: Icon(Icons.arrow_forward_ios, color: Colors.white, size: 24),
                style: IconButton.styleFrom(backgroundColor: Colors.black26),
              ),
            ),
          ),
        ],
      ),
    );
  }
}