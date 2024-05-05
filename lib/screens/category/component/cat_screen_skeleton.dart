import 'package:flutter/material.dart';
import 'package:shop_app/components/product_card.dart';
import 'package:shop_app/core/models/product.dart';
import 'package:shop_app/core/models/sub_category.dart';
import 'package:shop_app/screens/category/component/sub_category_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CatScreenSkeleton extends StatelessWidget {
  const CatScreenSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    SubCategory fakeCat = SubCategory.fromJson({
      "_id": "662e2bbbabdc45e2468088de",
      "name": "tring",
      "slug": "tring",
      "category": {
        "_id": "662e2b95abdc45e2468088db",
        "name": "men",
        "slug": "men",
        "image":
            "http://res.cloudinary.com/ds7tnriwu/image/upload/v1714301844/vtb0khtkmfkuuxdprv9v.png",
        "createdAt": "2024-04-28T10:57:25.399Z",
        "updatedAt": "2024-04-28T10:57:25.399Z",
        "__v": 0
      },
      "createdAt": "2024-04-28T10:58:03.391Z",
      "updatedAt": "2024-04-28T10:58:03.391Z",
      "__v": 0,
      "id": "662e2bbbabdc45e2468088de"
    });

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 150,
          backgroundColor: Colors.white,
          title: const Text(
            "Category",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Skeletonizer(child: SubCategoryCard(subCategory: fakeCat)),
              Skeletonizer(child: SubCategoryCard(subCategory: fakeCat)),
              Skeletonizer(child: SubCategoryCard(subCategory: fakeCat)),
              Skeletonizer(child: SubCategoryCard(subCategory: fakeCat)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Skeletonizer(
              child: ProductCard(
                product: demoProducts.first,
                onPress: () {},
              ),
            ),
            Skeletonizer(
              child: ProductCard(
                product: demoProducts.first,
                onPress: () {},
              ),
            ),
            Skeletonizer(
              child: ProductCard(
                product: demoProducts.first,
                onPress: () {},
              ),
            ),
            Skeletonizer(
              child: ProductCard(
                product: demoProducts.first,
                onPress: () {},
              ),
            ),
            Skeletonizer(
              child: ProductCard(
                product: demoProducts.first,
                onPress: () {},
              ),
            ),
            Skeletonizer(
              child: ProductCard(
                product: demoProducts.first,
                onPress: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
