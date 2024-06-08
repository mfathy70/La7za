import 'package:flutter/material.dart';
import 'package:shop_app/components/recommendation_card.dart';
import 'package:shop_app/core/models/ai_product.dart';
import 'package:shop_app/core/provider/ai_model_provider.dart';
import 'package:shop_app/screens/details/rec_details_screen.dart';

class ForYouScreen extends StatefulWidget {
  const ForYouScreen({super.key});

  @override
  State<ForYouScreen> createState() => _ForYouScreenState();
}

class _ForYouScreenState extends State<ForYouScreen> {
  AiModelProvider aiModelProvider = AiModelProvider();
  List<AiProduct>? recommendations = AiModelProvider.recommendations;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(children: [
      Text(
        "For You",
        style: Theme.of(context).textTheme.titleLarge,
      ),
      Expanded(
          child: Padding(
              padding: const EdgeInsets.all(16),
              child: GridView.builder(
                itemCount: recommendations!.length,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 0.8,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 16,
                ),
                itemBuilder: (context, index) => RecommendationCard(
                  product: recommendations![index],
                  onPress: () => Navigator.pushNamed(
                    context,
                    RecDetailsScreen.routeName,
                    arguments:
                        RecDetailsArguments(product: recommendations![index]),
                  ),
                ),
              )))
    ]));
  }
}
