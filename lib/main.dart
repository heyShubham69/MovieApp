import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import 'Screens/all_movies_screen.dart';
import 'models/hive/detail_screen_model.dart';
import 'models/hive/movies_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensures async initialization
  await dotenv.load(fileName: ".env"); // Load .env before app starts

  await Hive.initFlutter();
  Hive.registerAdapter(MoviesAdapter());
  Hive.registerAdapter(DetailScreenModelAdapter());
  await Hive.openBox<DetailScreenModel>('detailScreenBox');
  await Hive.openBox<Movies>('allMovies');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile List',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
            color: Colors.red,
          titleTextStyle: TextStyle(
            color: Colors.white, // Set white color for AppBar title
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(color: Colors.white), // White icons in AppBar
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: AllMoviesScreen(),
    );
  }
}
