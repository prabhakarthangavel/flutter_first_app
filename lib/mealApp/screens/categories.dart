import 'package:first_app/mealApp/models/categoryModel.dart';
import 'package:first_app/mealApp/screens/meals.dart';
import 'package:first_app/mealApp/widgets/categoryGridItem.dart';
import 'package:flutter/material.dart';

import '../dummyData/cataegoryData.dart';
import '../models/mealsModel.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key, required this.availableMeals});
  final List<MealsModel> availableMeals;

  @override
  State<StatefulWidget> createState() {
    return _CategoriesScreenState();
  }
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _annimationController;

  @override
  void initState() {
    super.initState();
    _annimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));

    _annimationController.forward();
  }

  @override
  void dispose() {
    _annimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _annimationController,
        child: GridView(
            padding: const EdgeInsets.all(24),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20),
            children: [
              for (final category in availableCategories)
                CategoryGridItem(
                    categoryModel: category,
                    onSelectCategory: () => _selectCategory(
                        context, category, widget.availableMeals))
            ]),
        builder: (context, child) => SlideTransition(
            position: 
                Tween(begin: const Offset(0, 0.3), end: const Offset(0, 0))
                    .animate(CurvedAnimation(
                        parent: _annimationController,
                        curve: Curves.easeInOut)),
            child: child));
  }

  void _selectCategory(BuildContext context, CategoryModel categoryModel,
      List<MealsModel> availableMeals) {
    final filteredMeals = availableMeals
        .where((meal) => meal.categories.contains(categoryModel.id))
        .toList();

    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => MealsScreen(
            title: categoryModel.title, selectedCategoryMeals: filteredMeals)));
  }
}
