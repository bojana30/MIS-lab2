import 'package:android_studio_lab2/widgets/category_card.dart';
import 'package:flutter/cupertino.dart';

import '../models/category.dart';

class CategoryGrid extends StatefulWidget {
  final List<Category> categories;

  const CategoryGrid({super.key, required this.categories});

  @override
  State<StatefulWidget> createState() => _CategoryGridState();
}

class _CategoryGridState extends State<CategoryGrid> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.categories.length,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return CategoryCard(category: widget.categories[index]);
      },
    );
  }
}
