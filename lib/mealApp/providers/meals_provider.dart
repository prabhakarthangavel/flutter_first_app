import 'package:first_app/mealApp/dummyData/cataegoryData.dart';
import 'package:first_app/mealApp/models/mealsModel.dart';
import 'package:first_app/mealApp/screens/mealDetail.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../dummyData/cataegoryData.dart';

final mealsProvider = Provider((ref) {
  return dummyMeals;
});



final favoriteMealsProvider = StateNotifierProvider<FavoriteMealsNotifier, List<MealsModel>>((ref) {
  return FavoriteMealsNotifier();
});

class FavoriteMealsNotifier extends StateNotifier<List<MealsModel>> {
  FavoriteMealsNotifier(): super([]);

  bool toggleMealFavoriteStatus(MealsModel mealModel) {
    final mealIsFavorite = state.contains(mealModel);

    if (mealIsFavorite) {
      state = state.where((meal) => meal.id != meal.id).toList();
      return false;
    }
    state = [...state, mealModel];
    return true;
  }
}




final filtersProvider = StateNotifierProvider<FiltesrNotifier, Map<Filter, bool>>((ref) => FiltesrNotifier());

enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan
}

class FiltesrNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltesrNotifier() : super({
    Filter.glutenFree: false,
    Filter.lactoseFree: false,
    Filter.vegetarian: false,
    Filter.vegan: false
  });

  void setFilters(Map<Filter, bool> choosenFilter) {
    state = choosenFilter;
  }

  void setFilter(Filter filter, bool isActive) {
    state = {...state, filter: isActive};
  }
}



final filtereredMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final activeFilters = ref.watch(filtersProvider);
  
  return meals.where((meal) {
      if (activeFilters[Filter.glutenFree]! && !meal.isGlutenFree) return false;
      if (activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree)return false;
      if (activeFilters[Filter.vegetarian]! && !meal.isVegetarian) return false;
      if (activeFilters[Filter.vegan]! && !meal.isVegan) return false;
      return true;
    }).toList();
});