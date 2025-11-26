import 'dart:convert';

import 'package:android_studio_lab2/models/category.dart';
import 'package:http/http.dart' as http;

import '../models/food.dart';
import '../models/recipe.dart';

class ApiService {
  final String url = "https://www.themealdb.com/api/json/v1/1";

  Future<List<Category>> fetchCategories() async {
    List<Category> list = [];
    final response = await http.get(Uri.parse("$url/categories.php"));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List categoriesJson = data['categories'];
      return categoriesJson.map((json) => Category.fromJson(json)).toList();
    } else {
      return list;
    }
  }

  Future<List<Food>> loadFoodList({required String category}) async {
    List<Food> foods = [];
    final response = await http.get(Uri.parse("$url/filter.php?c=$category"));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List foodsJson = data['meals'];
      return foodsJson.map((json) => Food.fromJson(json)).toList();
    } else {
      return foods;
    }
  }

  Future<Recipe> fetchRecipe({required int id}) async {
    final response = await http.get(Uri.parse("$url/lookup.php?i=$id"));

    final data = jsonDecode(response.body);
    final recipeJson = data['meals'][0];
    return Recipe.fromJson(recipeJson);
  }

  Future<Recipe> fetchRandomRecipe() async {
    final response = await http.get(Uri.parse("$url/random.php"));

    final data = jsonDecode(response.body);
    final recipeJson = data['meals'][0];
    return Recipe.fromJson(recipeJson);
  }

  Future<List<Food>> searchFood(String query) async {
    List<Food> foods = [];
    final response = await http.get(Uri.parse("$url/search.php?s=$query"));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List foodsJson = data['meals'];
      return foodsJson.map((json) => Food.fromJson(json)).toList();
    } else {
      return foods;
    }
  }
}
