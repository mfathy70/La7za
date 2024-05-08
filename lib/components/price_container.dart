import 'package:flutter/material.dart';
import '../../../components/rounded_icon_btn.dart';
import '../../../constants.dart';

class PriceContainer extends StatefulWidget {
  const PriceContainer({
    Key? key,
    required this.price,
    required this.add,
    required this.remove,
    required this.quantity,
  }) : super(key: key);

  final double price;
  final int quantity;
  final VoidCallback add;
  final VoidCallback remove;

  @override
  State<PriceContainer> createState() => _PriceContainerState();
}

class _PriceContainerState extends State<PriceContainer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Text(
            "${widget.price * widget.quantity} EGP",
            style: const TextStyle(
                color: kPrimaryColor,
                fontSize: 22,
                fontWeight: FontWeight.w500),
          ),
          const Spacer(),
          GestureDetector(
            onTap: widget.remove,
            child: const RoundedIconBtn(
              icon: Icons.remove,
              showShadow: true,
              height: 40,
              width: 40,
            ),
          ),
          const SizedBox(width: 20),
          Text(
            widget.quantity.toString(),
            style: const TextStyle(
                color: kTextColor, fontSize: 22, fontWeight: FontWeight.w500),
          ),
          const SizedBox(width: 20),
          GestureDetector(
            onTap: widget.add,
            child: const RoundedIconBtn(
              icon: Icons.add,
              showShadow: true,
              height: 40,
              width: 40,
            ),
          ),
        ],
      ),
    );
  }
}
