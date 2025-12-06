import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/food.dart';
import '../widgets/food_grid.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<StatefulWidget> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  bool _isLoading = true;
  late final List<Food> _favoriteFood;
  late final List<Food> _food;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _food = (ModalRoute.of(context)!.settings.arguments as List<Food>)
        .where((food) => food.favorite)
        .toList();
    setState(() {
      _favoriteFood = _food;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade400,
        title: const Text(
          "Favorites list",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: _getBodyContent(),
    );
  }

  Widget _getBodyContent() {
    if (_isLoading) {
      return _showLoading();
    }
    if (_favoriteFood.isEmpty) {
      return _showEmptyMessage();
    }
    return _showFavoritesGrid();
  }

  Widget _showLoading() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _showEmptyMessage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.search_off, size: 60, color: Colors.pink),
          const SizedBox(height: 16),
          const Text(
            'No favorites added yet',
            style: TextStyle(fontSize: 16, color: Colors.pink),
          ),
          const SizedBox(height: 8),
          Text(
            'Add some food you like!',
            style: TextStyle(fontSize: 14, color: Colors.pink.shade500),
          ),
        ],
      ),
    );
  }

  Widget _showFavoritesGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: FoodGrid(foods: _favoriteFood),
    );
  }
}
