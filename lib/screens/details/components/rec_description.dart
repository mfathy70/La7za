import 'package:flutter/material.dart';
import 'package:shop_app/core/models/ai_product.dart';
import 'package:shop_app/core/models/product.dart';
import 'package:shop_app/core/provider/ai_model_provider.dart';
import 'package:shop_app/core/provider/products_provider.dart';
import '../../../constants.dart';

class RecDescription extends StatefulWidget {
  const RecDescription({
    Key? key,
    required this.product,
    this.pressOnSeeMore,
  }) : super(key: key);

  final AiProduct product;
  final GestureTapCallback? pressOnSeeMore;

  @override
  State<RecDescription> createState() => _RecDescriptionState();
}

class _RecDescriptionState extends State<RecDescription> {
  ProductsProvider productsProvider = ProductsProvider();
  AiModelProvider aiModelProvider = AiModelProvider();
  bool fav = false;

  @override
  void initState() {
    checkFav();
    super.initState();
  }

  void checkFav() async {
    List<Product> userWishlist = await productsProvider.getWishlest();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 70,
                child: Text(
                  overflow: TextOverflow.fade,
                  widget.product.title!,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 70,
                child: Text(
                  widget.product.description!,
                  maxLines: 3,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 12,
              ),
              child: GestureDetector(
                onTap: () {},
                child: const Row(
                  children: [
                    Text(
                      "See More Detail",
                      style: TextStyle(
                          fontWeight: FontWeight.w600, color: kPrimaryColor),
                    ),
                    SizedBox(width: 5),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 12,
                      color: kPrimaryColor,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        IconButton(
          onPressed: () async {
            !fav
                ? productsProvider.addToWishlist(widget.product.id.toString())
                : productsProvider
                    .deleteFromWishlist(widget.product.id.toString());
            setState(() {
              fav = !fav;
            });
            aiModelProvider.sendToAi(widget.product.title!);
          },
          icon: Icon(
            fav ? Icons.favorite_rounded : Icons.favorite_border_rounded,
            color: fav ? kPrimaryColor : Colors.black,
          ),
        )
      ],
    );
  }
}
