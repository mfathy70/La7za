import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shop_app/core/models/product.dart';
import '../constants.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    this.width = 140,
    this.aspectRetio = 1.02,
    required this.product,
    required this.onPress,
  }) : super(key: key);

  final double width, aspectRetio;
  final Product product;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
          color: kSecondaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12)),
      child: GestureDetector(
        onTap: onPress,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      product.images![0],
                      fit: BoxFit.fitWidth,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.error,
                        color: kPrimaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                product.title!,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: kTextColor),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                "\$${product.price}",
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: kPrimaryColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: RatingBar(
                initialRating: product.rateCount != null
                    ? double.parse(product.rateCount.toString())
                    : 0,
                ignoreGestures: true,
                itemSize: 20,
                ratingWidget: RatingWidget(
                  full: const Icon(
                    Icons.star_rounded,
                    color: Colors.amber,
                  ),
                  half: const Icon(
                    Icons.star_half_rounded,
                    color: Colors.amber,
                  ),
                  empty: const Icon(
                    Icons.star_border_rounded,
                    color: Colors.amber,
                  ),
                ),
                onRatingUpdate: (value) {},
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
