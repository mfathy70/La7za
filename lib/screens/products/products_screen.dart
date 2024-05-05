import 'package:flutter/material.dart';
import 'package:shop_app/components/product_card.dart';
import 'package:shop_app/core/models/product.dart';
import 'package:shop_app/core/provider/categories_provider.dart';
import 'package:shop_app/core/provider/products_provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../details/details_screen.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key, this.screenTitle, this.byCat});
  static String routeName = "/products";

  final String? screenTitle;
  final String? byCat;

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  ProductsProvider productsProvider = ProductsProvider();
  CategoriesProvider categoriesProvider = CategoriesProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.screenTitle ?? "Products"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: FutureBuilder(
            future: productsProvider.getProducts(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return GridView.builder(
                  itemCount: 9,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 0.85,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) => Skeletonizer(
                    child: ProductCard(
                        product: demoProducts[index], onPress: () {}),
                  ),
                );
              } else if (snapshot.hasData) {
                return GridView.builder(
                  itemCount: snapshot.data!.length,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 0.85,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 10,
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
                  child: Text("Empty !!!!"),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
