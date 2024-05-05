import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class DiscountBanner extends StatelessWidget {
  const DiscountBanner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List items = [
      "assets/images/img1.png",
      "assets/images/img2.png",
      "assets/images/img3.png",
      "assets/images/img4.png"
    ];
    return Padding(
      padding: const EdgeInsets.all(20),
      child: CarouselSlider(
          items: items.map((img) => Image.asset(img)).toList(),
          options: CarouselOptions(
            autoPlay: true,
            enlargeCenterPage: false,
            viewportFraction: 1.0,
          )),
    );
  }
}
