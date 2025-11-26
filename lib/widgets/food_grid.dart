import 'package:flutter/cupertino.dart';

import '../models/food.dart';
import 'food_card.dart';

class FoodGrid extends StatefulWidget {
  final List<Food> foods;

  const FoodGrid({super.key, required this.foods});

  @override
  State<StatefulWidget> createState() => _FoodGridState();
}

class _FoodGridState extends State<FoodGrid> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.75,
      ),
      itemCount: widget.foods.length,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
          child: FoodCard(food: widget.foods[index]),
        );
      },
    );
  }
}
