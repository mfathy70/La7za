import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shop_app/components/product_card.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/core/provider/products_provider.dart';

import '../details/details_screen.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  ProductsProvider productsProvider = ProductsProvider();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Text(
            "Wishlist",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: FutureBuilder(
                  future: productsProvider.getWishlest(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: LoadingAnimationWidget.prograssiveDots(color: kPrimaryColor, size: 100),);
                    }
                    else if (snapshot.data!.isNotEmpty) {
                      return GridView.builder(
                        itemCount: snapshot.data?.length,
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200,
                          childAspectRatio: 0.8,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 16,
                        ),
                        itemBuilder: (context, index) => ProductCard(
                          product: snapshot.data![index],
                          onPress: () => Navigator.pushNamed(
                            context,
                            DetailsScreen.routeName,
                            arguments: ProductDetailsArguments(
                                product: snapshot.data![index]),
                          ),
                        ),
                      );
                    } else {
                      return const Center(
                        child: Text("Your wishlist is empty."),
                      );
                    }
                  }),
            ),
          )
        ],
      ),
    );
  }
}
