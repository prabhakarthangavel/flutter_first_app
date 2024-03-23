import 'package:first_app/mealApp/widgets/mealItemTrait.dart';
import '../models/mealsModel.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItem extends StatelessWidget {
  MealItem({super.key, required this.mealsModel, required this.mealSelected});

  final MealsModel mealsModel;

  String get complexityText {
    return mealsModel.complexity.name[0].toUpperCase() +
        mealsModel.complexity.name.substring(1);
  }

  String get affordabilityText {
    return mealsModel.affordability.name[0].toUpperCase() +
        mealsModel.complexity.name.substring(1);
  }

  final void Function() mealSelected;

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        clipBehavior: Clip.hardEdge,
        elevation: 2,
        child: InkWell(
            onTap: mealSelected,
            child: Stack(
              children: [
                Hero(
                    tag: mealsModel.id,
                    child: FadeInImage(
                        placeholder: MemoryImage(kTransparentImage),
                        image: NetworkImage(mealsModel.imageUrl),
                        fit: BoxFit.cover,
                        height: 200,
                        width: double.infinity)),
                Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                        color: Colors.black54,
                        padding: const EdgeInsets.symmetric(
                            vertical: 6, horizontal: 44),
                        child: Column(
                          children: [
                            Text(
                              mealsModel.title,
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                MealItemTrait(
                                    icon: Icons.schedule,
                                    label: '${mealsModel.duration} min'),
                                const SizedBox(width: 12),
                                MealItemTrait(
                                    icon: Icons.work, label: complexityText),
                                const SizedBox(width: 12),
                                MealItemTrait(
                                    icon: Icons.attach_money,
                                    label: affordabilityText)
                              ],
                            )
                          ],
                        )))
              ],
            )));
  }
}
