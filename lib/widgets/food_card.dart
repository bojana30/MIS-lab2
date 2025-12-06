import 'package:flutter/material.dart';

import '../models/food.dart';

class FoodCard extends StatefulWidget {
  final Food food;

  const FoodCard({super.key, required this.food});

  @override
  State<FoodCard> createState() => _FoodCardState();
}

class _FoodCardState extends State<FoodCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, "/recipe", arguments: widget.food);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.pink.shade300, width: 2),
        ),
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                widget.food.thumbnail,
                width: double.infinity,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            // Text(
            //   food.name,
            //   textAlign: TextAlign.center,
            //   style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            //   maxLines: 2,
            //   overflow: TextOverflow.ellipsis,
            // ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: Text(
                      widget.food.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),

                GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.food.favorite = !widget.food.favorite;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    child: Icon(
                      widget.food.favorite
                          ? Icons.favorite_rounded
                          : Icons.favorite_outline_rounded,
                      color: widget.food.favorite
                          ? Colors.pink.shade400
                          : Colors.grey.shade400,
                      size: 24,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
