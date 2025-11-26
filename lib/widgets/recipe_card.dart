import 'package:flutter/material.dart';

class RecipeCard extends StatelessWidget {
  final String thumbnail;

  const RecipeCard({super.key, required this.thumbnail});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      width: 250,
      child: Card(
        elevation: 8,
        shadowColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        clipBehavior: Clip.hardEdge,
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Image.network(thumbnail, fit: BoxFit.cover),
        ),
      ),
    );
  }
}
