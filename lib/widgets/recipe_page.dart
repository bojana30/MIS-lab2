import 'package:flutter/material.dart';

class DetailsGrid extends StatelessWidget {
  final List<String> ingredients;
  final String instructions;

  const DetailsGrid({
    super.key,
    required this.ingredients,
    required this.instructions,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        _simpleCard(
          title: "Ingredients",
          icon: Icons.local_florist,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: ingredients.map((item) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  children: [
                    Icon(Icons.circle, size: 10, color: Colors.pink.shade400),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(item, style: const TextStyle(fontSize: 16)),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 20),
        _simpleCard(
          title: "Instructions",
          icon: Icons.book,
          child: Text(
            instructions,
            style: const TextStyle(fontSize: 16, height: 1.5),
            textAlign: TextAlign.justify,
          ),
        ),

        const SizedBox(height: 30),
      ],
    );
  }

  Widget _simpleCard({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.pink.shade600),
              const SizedBox(width: 10),
              Text(
                title,
                style: TextStyle(
                  color: Colors.pink.shade600,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }
}
