import 'package:first_app/mealApp/dummyData/cataegoryData.dart';
import 'package:first_app/mealApp/models/mealsModel.dart';
import 'package:first_app/mealApp/screens/categories.dart';
import 'package:first_app/mealApp/screens/filtersScreen.dart';
import 'package:first_app/mealApp/screens/meals.dart';
import 'package:first_app/mealApp/widgets/mainDrawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:first_app/mealApp/providers/meals_provider.dart';

import '../providers/meals_provider.dart';

class Tabs extends ConsumerStatefulWidget {
  Tabs({super.key});

  @override
  ConsumerState<Tabs> createState() {
    return _TabsState();
  }
}

class _TabsState extends ConsumerState<Tabs> {
  int _selectedPageIndex = 0;

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      await Navigator.of(context).push<Map<Filter, bool>>(
          MaterialPageRoute(builder: (ctx) => const FiltersScreen()));
    } else if (identifier == 'allMeals') {
      print('**allMeals $identifier');
      Navigator.of(context).push(MaterialPageRoute(
          builder: (ctx) => MealsScreen(
              title: 'All Meals', selectedCategoryMeals: ref.watch(filtereredMealsProvider))));
    }
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(Object context) {
    final availableMeals = ref.watch(filtereredMealsProvider);

    Widget activePage = CategoriesScreen(
        availableMeals: availableMeals);
    String activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      final List<MealsModel> favouriteMeals = ref
          .watch(favoriteMealsProvider);
      activePage = MealsScreen(selectedCategoryMeals: favouriteMeals);
      activePageTitle = 'Your Favorites';
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(activePageTitle),
        ),
        drawer: MainDrawer(onScreenSelect: _setScreen),
        body: activePage,
        bottomNavigationBar: Theme(
            data: ThemeData.dark().copyWith(
                splashFactory: NoSplash.splashFactory,
                highlightColor: Colors.transparent,
                primaryColor: Colors.black),
            child: BottomNavigationBar(
                onTap: _selectPage,
                currentIndex: _selectedPageIndex,
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.set_meal), label: 'Categories'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.star), label: 'Favorites')
                ])));
  }
}
