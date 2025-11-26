import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/category.dart';
import '../services/api_service.dart';
import '../widgets/category_list.dart';

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final List<Category> _categories;
  List<Category> _filteredCategories = [];
  bool _isLoading = true;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _loadCategories();
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
            icon: const Icon(Icons.loop),
            tooltip: "Surprise Recipe",
            onPressed: () {
              Navigator.pushNamed(context, "/random_recipe");
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Find your favorite category...',
                prefixIcon: const Icon(Icons.fastfood, color: Colors.pink),
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
                _filterCategories(value);
              },
            ),
          ),
          Expanded(
            child: _filteredCategories.isEmpty && _searchQuery.isNotEmpty
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.no_food, size: 72, color: Colors.pink),
                  SizedBox(height: 16),
                  Text(
                    'Oops! No categories found.',
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
              child: CategoryGrid(categories: _filteredCategories),
            ),
          ),
        ],
      ),
    );
  }

  void _loadCategories() async {
    final categoriesList = await _apiService.fetchCategories();
    setState(() {
      _categories = categoriesList;
      _filteredCategories = categoriesList;
      _isLoading = false;
    });
  }

  void _filterCategories(String query) {
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _filteredCategories = _categories;
      } else {
        _filteredCategories = _categories
            .where((c) => c.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }
}
