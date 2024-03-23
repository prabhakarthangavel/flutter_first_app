import 'package:first_app/mealApp/models/mealsModel.dart';
import 'package:first_app/mealApp/screens/mealDetail.dart';
import 'package:first_app/mealApp/widgets/mealItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MealsScreen extends ConsumerWidget {
  const MealsScreen(
      {super.key, this.title, required this.selectedCategoryMeals});

  final String? title;
  final List<MealsModel> selectedCategoryMeals;

  void mealSelected(BuildContext context, MealsModel meal) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => MealDetail(meal: meal)));
  }

  @override
  Widget build(BuildContext context, WidgetRef widgetRef) {
    Widget content = Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Uh oh ... nothing here!',
            style: const TextStyle(fontSize: 20)
                .copyWith(color: Theme.of(context).colorScheme.onBackground)),
        const SizedBox(height: 16),
        Text('Try selecting a different category!',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Theme.of(context).colorScheme.onBackground))
      ],
    ));

    // final meals = widgetRef.watch(mealsProvider);
    final meals = selectedCategoryMeals;
    if (meals.isNotEmpty) {
      content = ListView.builder(
          itemCount: meals.length,
          itemBuilder: (ctx, index) => MealItem(
              mealsModel: meals[index],
              mealSelected: () => mealSelected(context, meals[index])));
    }

    if (title == null) {
      return content;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }
}
