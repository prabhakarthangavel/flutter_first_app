import 'package:first_app/shoppingListApp/widgets/groceryList.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



final theme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.dark,
        seedColor: const Color.fromARGB(255, 147, 229, 250),
        surface: const Color.fromARGB(255, 42, 51, 59)),
    scaffoldBackgroundColor: const Color.fromARGB(255, 50, 58, 60),
    textTheme:  const TextTheme().apply(bodyColor: Colors.white, displayColor: Colors.white));

void main() {
  runApp(const ProviderScope(child: App()));
}

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: theme,
        home: const GroceryList());
  }
}

// MealsScreen(title: 'Some Category', meals: dummyMeals)
