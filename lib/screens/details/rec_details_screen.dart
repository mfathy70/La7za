import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/components/price_container.dart';
import 'package:shop_app/core/models/ai_product.dart';
import 'package:shop_app/core/models/product.dart';
import 'package:shop_app/core/provider/cart_provider.dart';
import 'package:shop_app/screens/details/components/rec_description.dart';
import 'package:shop_app/screens/details/components/rec_product_images.dart';
import 'components/product_description.dart';
import 'components/product_images.dart';
import 'components/top_rounded_container.dart';

class RecDetailsScreen extends StatefulWidget {
  static String routeName = "/details";

  const RecDetailsScreen({super.key});

  @override
  State<RecDetailsScreen> createState() => _RecDetailsScreenState();
}

class _RecDetailsScreenState extends State<RecDetailsScreen> {
  CartProvider cartProvider = CartProvider();
  int quantity = 1;

  void _incrementQuantity() {
    setState(() {
      quantity++;
      print(quantity);
    });
  }

  void _decrementQuantity() {
    setState(() {
      quantity != 1 ? quantity-- : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final RecDetailsArguments agrs =
        ModalRoute.of(context)!.settings.arguments as RecDetailsArguments;

    final product = agrs.product;

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFFF5F6F9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: EdgeInsets.zero,
              elevation: 0,
              backgroundColor: Colors.white,
            ),
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
              size: 20,
            ),
          ),
        ),
        actions: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 20),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    Text(
                      double.parse(product.rateCount.toString()).toString(),
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 4),
                    SvgPicture.asset("assets/icons/Star Icon.svg"),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: ListView(
        children: [
          RecProductImages(product: product),
          TopRoundedContainer(
            color: Colors.white,
            child: Column(
              children: [
                RecDescription(
                  product: product,
                  pressOnSeeMore: () {},
                ),
                TopRoundedContainer(
                  color: const Color(0xFFF6F7F9),
                  child: Column(
                    children: [
                      PriceContainer(
                        price: product.price!,
                        quantity: quantity,
                        add: _incrementQuantity,
                        remove: _decrementQuantity,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: TopRoundedContainer(
        color: Colors.white,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: ElevatedButton(
              onPressed: () {
                cartProvider.addToCart(product.id!, quantity);
              },
              child: const Text("Add To Cart"),
            ),
          ),
        ),
      ),
    );
  }
}

class RecDetailsArguments {
  final AiProduct product;

  RecDetailsArguments({required this.product});
}
