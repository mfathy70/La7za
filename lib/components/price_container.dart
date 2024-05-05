import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../../components/rounded_icon_btn.dart';
import '../../../constants.dart';

class PriceContainer extends StatefulWidget {
  const PriceContainer({
    Key? key,
    required this.price,
  }) : super(key: key);

  final double price;

  @override
  State<PriceContainer> createState() => _PriceContainerState();
}

class _PriceContainerState extends State<PriceContainer> {
  int quantity = 1;

  void _incrementQuantity() {
    setState(() {
      quantity++;
      print(quantity);
    });
  }

  void _decrementQuantity() {
    setState(() {
      quantity != 1 ? quantity-- : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Text(
            "${widget.price * quantity} EGP",
            style: const TextStyle(
                color: kPrimaryColor,
                fontSize: 22,
                fontWeight: FontWeight.w500),
          ),
          const Spacer(),
          GestureDetector(
            onTap: _decrementQuantity,
            child: const RoundedIconBtn(
              icon: Icons.remove,
            ),
          ),
          const SizedBox(width: 20),
          Text(
            quantity.toString(),
            style: const TextStyle(
                color: kTextColor, fontSize: 22, fontWeight: FontWeight.w500),
          ),
          const SizedBox(width: 20),
          GestureDetector(
            onTap: _incrementQuantity,
            child: const RoundedIconBtn(
              icon: Icons.add,
              showShadow: true,
            ),
          ),
        ],
      ),
    );
  }
}
