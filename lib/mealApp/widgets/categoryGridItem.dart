import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:first_app/mealApp/providers/meals_provider.dart';

import '../models/categoryModel.dart';
import '../models/mealsModel.dart';
import '../screens/filtersScreen.dart';

class CategoryGridItem extends ConsumerWidget {
  const CategoryGridItem(
      {super.key,
      required this.categoryModel,
      required this.onSelectCategory});

  final CategoryModel categoryModel;
  final void Function() onSelectCategory;

  List<MealsModel> getAvailableCategories(WidgetRef widgetRef) {
    List<MealsModel> mealList = [];
    final dummyMeals = widgetRef.watch(mealsProvider);
    final Map<Filter, bool> selectedFilters = widgetRef.watch(filtersProvider);
    for (int i = 0; i < dummyMeals.length; i++) {
      if (dummyMeals[i].categories.contains(categoryModel.id) &&
          (!selectedFilters[Filter.glutenFree]! || dummyMeals[i].isGlutenFree == selectedFilters[Filter.glutenFree]) &&
          (!selectedFilters[Filter.vegan]! || dummyMeals[i].isVegan == selectedFilters[Filter.vegan]) &&
          (!selectedFilters[Filter.vegetarian]! || dummyMeals[i].isVegetarian == selectedFilters[Filter.vegetarian]) &&
          (!selectedFilters[Filter.lactoseFree]! || dummyMeals[i].isLactoseFree == selectedFilters[Filter.lactoseFree])) {
        mealList.add(dummyMeals[i]);
      }
    }
    return mealList;
  }

  @override
  Widget build(BuildContext context, WidgetRef widgetRef) {
    final mealList = getAvailableCategories(widgetRef);
    return InkWell(
      onTap: onSelectCategory,
      splashColor: Theme.of(context).focusColor,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(colors: [
              mealList.length > 0
                  ? categoryModel.color.withOpacity(0.5)
                  : Colors.grey.withOpacity(0.5),
              mealList.length > 0
                  ? categoryModel.color.withOpacity(0.5)
                  : Colors.grey
                ..withOpacity(0.9),
            ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        child: Padding(
          padding: const EdgeInsets.only(left: 10, top: 5),
          child: Text(categoryModel.title,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground)),
        ),
      ),
    );
  }
}
