import 'package:flutter/material.dart';
import 'package:shop_app/core/models/product.dart';
import 'package:shop_app/core/provider/products_provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../components/product_card.dart';
import '../../details/details_screen.dart';
import '../../products/products_screen.dart';
import 'section_title.dart';

class PopularProducts extends StatefulWidget {
  const PopularProducts({super.key});

  @override
  State<PopularProducts> createState() => _PopularProductsState();
}

class _PopularProductsState extends State<PopularProducts> {
  ProductsProvider productsProvider = ProductsProvider();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionTitle(
          title: "Popular Products",
          press: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return const ProductsScreen(
                  screenTitle: "Popular Products",
                );
              }),
            );
          },
        ),
        FutureBuilder(
          future: productsProvider.getProducts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...List.generate(
                      3,
                      (index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Skeletonizer(
                            child: ProductCard(
                                product: demoProducts[0], onPress: () {}),
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
              );
            } else if (snapshot.hasData) {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...List.generate(
                      snapshot.data!.length,
                      (index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: ProductCard(
                            product: snapshot.data![index],
                            onPress: () => Navigator.pushNamed(
                              context,
                              DetailsScreen.routeName,
                              arguments: ProductDetailsArguments(
                                  product: snapshot.data![index]),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
              );
            } else {
              return const Center(
                child: Text("EMPTY!!"),
              );
            }
          },
        )
      ],
    );
  }
}
