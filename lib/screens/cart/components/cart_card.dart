import 'package:flutter/material.dart';
import 'package:shop_app/components/rounded_icon_btn.dart';
import 'package:shop_app/core/models/Cart.dart';

import '../../../constants.dart';

class CartCard extends StatelessWidget {
  const CartCard({
    Key? key,
    required this.cartItem,
    this.add,
    this.remove,
  }) : super(key: key);

  final CartItem cartItem;
  final VoidCallback? add;
  final VoidCallback? remove;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 88,
          child: AspectRatio(
            aspectRatio: 0.88,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: kSecondaryColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.network(cartItem.product!.images![0]),
            ),
          ),
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 140,
              child: Text(
                cartItem.product!.title!,
                style: const TextStyle(color: Colors.black, fontSize: 16),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 8),
            Text.rich(
              TextSpan(
                text: "\$${cartItem.product!.price}",
                style: const TextStyle(
                    fontWeight: FontWeight.w600, color: kPrimaryColor),
                children: [
                  TextSpan(
                      text: " x${cartItem.quantity}",
                      style: Theme.of(context).textTheme.bodyLarge),
                ],
              ),
            )
          ],
        ),
        const Expanded(child: SizedBox.shrink()),
        Row(
          children: [
            GestureDetector(
              onTap: add,
              child: const RoundedIconBtn(
                icon: Icons.add_rounded,
                showShadow: true,
                height: 30,
                width: 30,
              ),
            ),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: remove,
              child: const RoundedIconBtn(
                icon: Icons.remove_rounded,
                showShadow: true,
                height: 30,
                width: 30,
              ),
            ),
          ],
        )
      ],
    );
  }
}
