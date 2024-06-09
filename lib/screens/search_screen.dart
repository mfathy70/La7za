import 'package:flutter/material.dart';
import 'package:shop_app/components/product_card.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/core/models/product.dart';
import 'package:shop_app/core/provider/categories_provider.dart';
import 'package:shop_app/core/provider/products_provider.dart';
import 'package:shop_app/screens/details/details_screen.dart';
import 'package:shop_app/screens/home/components/search_field.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key, this.screenTitle, this.byCat});
  static String routeName = "/search";

  final String? screenTitle;
  final String? byCat;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  ProductsProvider productsProvider = ProductsProvider();
  CategoriesProvider categoriesProvider = CategoriesProvider();
  List<Product> products = [];
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Form(
          child: TextFormField(
            autofocus: true,
            onChanged: (value) async {
              List<Product> response =
                  await productsProvider.searchProduct(value);
              setState(() {
                products = response;
              });
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: kSecondaryColor.withOpacity(0.1),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              border: searchOutlineInputBorder,
              focusedBorder: searchOutlineInputBorder,
              enabledBorder: searchOutlineInputBorder,
              hintText: "Search product",
              prefixIcon: const Icon(Icons.search),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: loading
              ? GridView.builder(
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
                )
              : products.isEmpty
                  ? Center(
                      child: Text("Empty !!!!"),
                    )
                  : GridView.builder(
                      itemCount: products.length,
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        childAspectRatio: 0.85,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 10,
                      ),
                      itemBuilder: (context, index) => ProductCard(
                        product: products[index],
                        onPress: () => Navigator.pushNamed(
                          context,
                          DetailsScreen.routeName,
                          arguments:
                              ProductDetailsArguments(product: products[index]),
                        ),
                      ),
                    ),
        ),
      ),
    );
  }
}
