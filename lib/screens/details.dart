import 'package:flutter/material.dart';
import '../models/food.dart';
import '../services/api_service.dart';

import '../widgets/food_grid.dart';

class DetailsPage extends StatefulWidget {
  final String title;

  const DetailsPage({super.key, required this.title});

  @override
  State<DetailsPage> createState() => _DetailsState();
}

class _DetailsState extends State<DetailsPage> {
  late List<Food> _foods;
  bool _isLoading = true;
  final ApiService _apiService = ApiService();
  late String categoryName;
  final TextEditingController _searchController = TextEditingController();
  bool isSearching = true;
  List<Food> _filteredFood = [];
  String _searchQuery = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    categoryName = ModalRoute.of(context)!.settings.arguments as String;
    _loadFoods();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade800,
        title: Text(
          widget.title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, "/favorite_recipes", arguments: _foods);
            },
            icon: const Icon(Icons.favorite),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search the food by name...',
                      prefixIcon: const Icon(
                        Icons.fastfood,
                        color: Colors.pink,
                      ),
                      filled: true,
                      fillColor: Colors.pink.shade50,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                      _searchFoodByName(value);
                    },
                  ),
                ),
                Expanded(
                  child: _filteredFood.isEmpty && _searchQuery.isNotEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.no_food, size: 72, color: Colors.pink),
                              SizedBox(height: 16),
                              Text(
                                'No Food found',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.pink,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          child: FoodGrid(foods: _filteredFood),
                        ),
                ),
              ],
            ),
    );
  }

  void _loadFoods() async {
    final foodsList = await _apiService.loadFoodList(category: categoryName);
    setState(() {
      _foods = foodsList;
      _filteredFood = foodsList;
      _isLoading = false;
    });
  }

  Future<void> _searchFoodByName(String name) async {
    if (name.isEmpty) return;
    setState(() {
      isSearching = true;
    });

    final result = await _apiService.searchFood(name);
    setState(() {
      isSearching = false;
      _filteredFood = result;
    });
  }
}
