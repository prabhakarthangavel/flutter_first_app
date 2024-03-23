import 'package:flutter/material.dart';
import '../models/mealsModel.dart';
import 'package:first_app/mealApp/providers/meals_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MealDetail extends ConsumerStatefulWidget {
  const MealDetail({super.key, required this.meal});

  final MealsModel meal;
  @override
  ConsumerState<MealDetail> createState() => _MealDetailState();
}

class _MealDetailState extends ConsumerState<MealDetail> {
  @override
  Widget build(BuildContext context) {
    final MealsModel meal = widget.meal;
    final favouriteMeals = ref.watch(favoriteMealsProvider);
    // favouriteMeals!.forEach((element) => print("**favourite ${element.title}"));
    var iconType = favouriteMeals.contains(meal) ? Icons.star : Icons.star_border;
    return Scaffold(
      appBar: AppBar(title: Text(meal.title), actions: [
        IconButton(
            onPressed: () {
              //ref will be available in ConsumerStatefulWidget
              final wasAdded = ref
                  .read(favoriteMealsProvider.notifier)
                  .toggleMealFavoriteStatus(meal);
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(wasAdded ? 'Meal added successfully' : 'Meal removed')));
            },
            icon: AnimatedSwitcher(duration: const Duration(milliseconds: 300), 
            transitionBuilder: (child, animation) {
              return RotationTransition(turns: Tween<double>(begin: 0.8, end: 1.0).animate(animation), child: child);
             },
            child: Icon(iconType, key: ValueKey(iconType))))
      ]),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(tag: meal.id, child: Image.network(meal.imageUrl,
                height: 300, width: double.infinity, fit: BoxFit.cover)),
            const SizedBox(height: 14),
            Text('Ingredients',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 14),
            for (final ingredient in meal.ingredients)
              Text(ingredient,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground)),
            const SizedBox(height: 24),
            Text('Steps',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontWeight: FontWeight.bold)),
            for (final step in meal.steps)
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
                    child: Text(step,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color:
                                Theme.of(context).colorScheme.onBackground))),
              ),
            const SizedBox(height: 24)
          ],
        ),
      ),
    );
  }
}
