import 'package:first_app/shoppingListApp/models/grocery_item.dart';
import 'package:first_app/shoppingListApp/data/categories.dart';

final groceryItems = [
  GroceryItem(
      id: 'a',
      name: 'Milk',
      quantity: 1,
      category: categories[Categories.dairy]!),
  GroceryItem(
      id: 'b',
      name: 'Bananas',
      quantity: 5,
      category: categories[Categories.fruit]!),
  GroceryItem(
      id: 'c',
      name: 'Beef Steak',
      quantity: 1,
      category: categories[Categories.meat]!)
];

enum Categories {
  dairy,
  fruit,
  meat,
  vegetables,
  sweets,
  carbs,
  spices,
  convenience,
  hygiene,
  other
}