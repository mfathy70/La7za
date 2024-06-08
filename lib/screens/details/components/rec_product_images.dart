import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shop_app/core/models/ai_product.dart';
import 'package:shop_app/core/models/product.dart';
import '../../../constants.dart';

class RecProductImages extends StatefulWidget {
  const RecProductImages({
    Key? key,
    required this.product,
  }) : super(key: key);

  final AiProduct product;

  @override
  _RecProductImagesState createState() => _RecProductImagesState();
}

class _RecProductImagesState extends State<RecProductImages> {
  int selectedImage = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 238,
          child: AspectRatio(
            aspectRatio: 1,
            child: Image.network(
              widget.product.images![selectedImage],
              fit: BoxFit.contain,
            ),
          ),
        ),
        const SizedBox(height: 20),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...List.generate(
                widget.product.images!.length,
                (index) => SmallProductImage(
                  isSelected: index == selectedImage,
                  press: () {
                    setState(() {
                      selectedImage = index;
                    });
                  },
                  image: widget.product.images![index],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class SmallProductImage extends StatefulWidget {
  const SmallProductImage(
      {super.key,
      required this.isSelected,
      required this.press,
      required this.image});

  final bool isSelected;
  final VoidCallback press;
  final String image;

  @override
  State<SmallProductImage> createState() => _SmallRecProductImagestate();
}

class _SmallRecProductImagestate extends State<SmallProductImage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.press,
      child: AnimatedContainer(
        duration: defaultDuration,
        margin: const EdgeInsets.only(right: 16),
        padding: const EdgeInsets.all(8),
        height: 48,
        width: 48,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: kPrimaryColor.withOpacity(widget.isSelected ? 1 : 0)),
        ),
        child: Image.network(widget.image),
      ),
    );
  }
}
