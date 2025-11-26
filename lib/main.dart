import 'package:android_studio_lab2/screens/details.dart';
import 'package:android_studio_lab2/screens/home.dart';
import 'package:android_studio_lab2/screens/random_recipe.dart';
import 'package:android_studio_lab2/screens/recipe.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => const MyHomePage(title: 'Food App'),
        "/details": (context) => const DetailsPage(title: 'Food App'),
        "/recipe": (context) => RecipePage(),
        "/random_recipe": (context) => RandomPage(),
      },
    );
  }
}
