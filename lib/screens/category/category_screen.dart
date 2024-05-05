import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shop_app/components/product_card.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/core/models/product.dart';
import 'package:shop_app/core/models/sub_category.dart';
import 'package:shop_app/core/provider/categories_provider.dart';
import 'package:shop_app/core/provider/products_provider.dart';
import 'package:shop_app/screens/category/component/sub_category_card.dart';
import 'package:shop_app/screens/details/details_screen.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CategoryScreen extends StatefulWidget {
  static String routeName = "/category";

  final String? screenTitle;
  final String? catId;

  const CategoryScreen({super.key, this.screenTitle, this.catId});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  ProductsProvider productsProvider = ProductsProvider();
  CategoriesProvider categoriesProvider = CategoriesProvider();
  List<Product> productsList = [];
  List<SubCategory> subCategories = [];
  bool loading = false;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  _fetchData() async {
    List<SubCategory> subCats =
        await categoriesProvider.getSubCategory(widget.catId!);
    subCategories = subCats;
    List<Product> prodList =
        await productsProvider.getSubCatProducts(subCats.first.id!);
    for (Product product in prodList) {
      setState(() {
        productsList.add(product);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (subCategories.isEmpty) {
      return Scaffold(
        body: Center(
          child:
              LoadingAnimationWidget.waveDots(color: kPrimaryColor, size: 80),
        ),
      );
    } else if (subCategories.isNotEmpty) {
      List<Widget> tabs = subCategories.map((item) {
        return SubCategoryCard(subCategory: item);
      }).toList();

      return DefaultTabController(
        length: subCategories.length,
        initialIndex: 0,
        child: Scaffold(
            appBar: AppBar(
              toolbarHeight: 150,
              backgroundColor: Colors.white,
              title: Text(
                widget.screenTitle ?? "Category",
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w600),
              ),
              centerTitle: false,
              bottom: TabBar(
                tabAlignment: TabAlignment.start,
                indicatorColor: kPrimaryColor,
                labelColor: kPrimaryColor,
                indicatorSize: TabBarIndicatorSize.label,
                isScrollable: true,
                tabs: tabs,
                onTap: (indx) async {
                  setState(() {
                    loading = true;
                  });
                  List<Product> prodList = await productsProvider
                      .getSubCatProducts(subCategories[indx].id!);
                  setState(() {
                    productsList.clear();
                    for (Product product in prodList) {
                      setState(() {
                        productsList.add(product);
                      });
                    }
                  });
                  setState(() {
                    loading = false;
                  });
                },
              ),
            ),
            body: loading || productsList.isEmpty
                ? GridView.builder(
                    padding: const EdgeInsets.all(10),
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
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
                : GridView(
                    padding: const EdgeInsets.all(10),
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 0.85,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    children: productsList
                        .map((product) => ProductCard(
                              product: product,
                              onPress: () => Navigator.pushNamed(
                                context,
                                DetailsScreen.routeName,
                                arguments:
                                    ProductDetailsArguments(product: product),
                              ),
                            ))
                        .toList(),
                  )),
      );
    } else {
      return const Scaffold(
        body: Center(
          child: Text("EMPTY!!!"),
        ),
      );
    }
  }
}
