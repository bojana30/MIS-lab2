import 'package:android_studio_lab2/widgets/recipe_card.dart';
import 'package:flutter/material.dart';

import '../models/recipe.dart';
import '../services/api_service.dart';
import '../widgets/recipe_page.dart';
import '../widgets/recipe_nameCard.dart';

class RandomPage extends StatefulWidget {
  const RandomPage({super.key});

  @override
  State<RandomPage> createState() => _RandomState();
}

class _RandomState extends State<RandomPage> {
  bool _isLoading = true;
  final ApiService _apiService = ApiService();
  late Recipe recipe;

  @override
  void initState() {
    super.initState();
    _loadRandomRecipe();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                      top: 50,
                      left: 16,
                      right: 16,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "Random Recipe",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.pink.shade800,
                          ),
                        ),
                        const SizedBox(width: 48),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.pink.shade100,
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: RecipeCard(thumbnail: recipe.thumbnail),
                    ),
                  ),
                  const SizedBox(height: 20),
                  RecipeNameCard(title: recipe.name),
                  const SizedBox(height: 20),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.pink.shade100,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: DetailsGrid(
                      ingredients: recipe.ingredients,
                      instructions: recipe.instructions,
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
    );
  }

  void _loadRandomRecipe() async {
    final Recipe recipetmp = await _apiService.fetchRandomRecipe();

    setState(() {
      recipe = recipetmp;
      _isLoading = false;
    });
  }
}
