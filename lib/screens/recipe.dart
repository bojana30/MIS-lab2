import 'package:android_studio_lab2/widgets/recipe_card.dart';
import 'package:flutter/material.dart';

import '../models/food.dart';
import '../models/recipe.dart';
import '../services/api_service.dart';
import '../widgets/recipe_page.dart';
import '../widgets/recipe_nameCard.dart';

class RecipePage extends StatefulWidget {
  const RecipePage({super.key});

  @override
  State<RecipePage> createState() => _RecipeState();
}

class _RecipeState extends State<RecipePage> {
  bool _isLoading = true;
  final ApiService _apiService = ApiService();
  late Food food;
  late Recipe recipe;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    food = ModalRoute.of(context)!.settings.arguments as Food;
    _loadRecipe();
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
                      bottom: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.pink.shade100,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(24),
                        bottomRight: Radius.circular(24),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.pink.shade200,
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "Recipe Details",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.pink.shade800,
                          ),
                        ),
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
                          color: Colors.pink.shade200,
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: RecipeCard(thumbnail: recipe.thumbnail),
                    ),
                  ),
                  const SizedBox(height: 16),
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

  void _loadRecipe() async {
    final Recipe recipetemp = await _apiService.fetchRecipe(id: food.id);

    setState(() {
      recipe = recipetemp;
      _isLoading = false;
    });
  }
}
