import 'package:android_studio_lab2/screens/details.dart';
import 'package:android_studio_lab2/screens/favorites.dart';
import 'package:android_studio_lab2/screens/home.dart';
import 'package:android_studio_lab2/screens/random.dart';
import 'package:android_studio_lab2/screens/recipe.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("BG Message: ${message.notification?.title}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => const MyHomePage(title: 'Food App'),
        "/details": (context) => const DetailsPage(title: 'Food App'),
        "/recipe": (context) => const RecipePage(),
        "/random_recipe": (context) => const RandomPage(),
        "/favorite_recipes": (context) => const FavoritesPage(),
      },
    );
  }
}
