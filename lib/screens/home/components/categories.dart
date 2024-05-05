import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/core/provider/categories_provider.dart';
import 'package:shop_app/screens/category/category_screen.dart';
import 'package:shop_app/screens/home/components/section_title.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  CategoriesProvider categoriesProvider = CategoriesProvider();

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categories = [
      {"icon": "assets/svg/man.svg", "text": "Men"},
      {"icon": "assets/svg/woman.svg", "text": "Women"},
      {"icon": "assets/svg/child.svg", "text": "Kids"},
      {"icon": "assets/svg/electronics.svg", "text": "Electronics"},
      {"icon": "assets/svg/tv.svg", "text": "TV"},
      {"icon": "assets/svg/mobile.svg", "text": "Phones"},
      {"icon": "assets/svg/fashion.svg", "text": "Fashion"},
    ];
    return Column(
      children: [
        SectionTitle(
          title: "Categories",
          press: () {},
        ),
        FutureBuilder(
          future: categoriesProvider.getCategories(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...List.generate(
                      5,
                      (index) {
                        return Skeletonizer(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: CategoryCard(
                              icon: "  ",
                              text: categories[index]["text"],
                              press: () {},
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasData) {
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                    snapshot.data!.length,
                    (index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: CategoryCard(
                        icon: categories[index]["icon"],
                        text: snapshot.data![index].name!,
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return CategoryScreen(
                                screenTitle: snapshot.data![index].name,
                                catId: snapshot.data![index].id,
                              );
                            }),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return const Center(
                child: Text("EMPTY!!"),
              );
            }
          },
        ),
      ],
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.icon,
    required this.text,
    required this.press,
  }) : super(key: key);

  final String icon, text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            height: 56,
            width: 56,
            decoration: BoxDecoration(
              color: kSecondaryColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: SvgPicture.asset(
              icon,
              color: kPrimaryColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(text, textAlign: TextAlign.center)
        ],
      ),
    );
  }
}
