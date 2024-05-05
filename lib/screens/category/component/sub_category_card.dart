import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/core/models/sub_category.dart';

class SubCategoryCard extends StatelessWidget {
  const SubCategoryCard({
    Key? key,
    required this.subCategory,
  }) : super(key: key);

  final SubCategory subCategory;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            color: kSecondaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Image.network(
            subCategory.category!.image ??
                "http://res.cloudinary.com/ds7tnriwu/image/upload/v1714301844/vtb0khtkmfkuuxdprv9v.png",
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) => const Icon(
              Icons.error,
              color: kPrimaryColor,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          subCategory.name!,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
