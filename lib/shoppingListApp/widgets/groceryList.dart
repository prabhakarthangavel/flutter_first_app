import 'package:first_app/shoppingListApp/data/categories.dart';
import 'package:first_app/shoppingListApp/models/grocery_item.dart';
import 'package:first_app/shoppingListApp/widgets/newItem.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  List<GroceryItem> _groceryItems = [];
  var isLoading = true;
  bool error = false;
  void _loadData() async {
    final url = Uri.https(
        'shoppinglistflutter-68d83-default-rtdb.firebaseio.com',
        'shoppingList.json');
    var response;
    try {
      response = await http.get(url);
      final Map<String, dynamic> listData = json.decode(response.body) ?? {};
      isLoading = false;
      List<GroceryItem> loadedData = [];
      for (final item in listData.entries) {
        final category = categories.entries
            .firstWhere(
                (catItem) => catItem.value.name == item.value['category'])
            .value;
        loadedData.add(GroceryItem(
            id: item.key,
            name: item.value['name'],
            quantity: item.value['quantity'],
            category: category));
      }

      setState(() {
        _groceryItems = loadedData;
      });
    } catch (err) {
      setState(() {
        isLoading = false;
        error = true;
      });
      return;
    }
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    Widget body;
    if (_groceryItems.isNotEmpty) {
      body = ListView.builder(
          itemCount: _groceryItems.length,
          itemBuilder: (cts, index) => Dismissible(
                onDismissed: (direction) {
                  _removeItem(_groceryItems[index], index);
                },
                confirmDismiss: (direction) async {
                  if (direction == DismissDirection.endToStart) {
                    return true;
                  }
                  return false;
                },
                background:
                    Container(color: const Color.fromARGB(255, 245, 96, 85)),
                key: ValueKey(_groceryItems[index].id),
                child: ListTile(
                    title: Text(_groceryItems[index].name),
                    leading: Container(
                      width: 24,
                      height: 24,
                      color: _groceryItems[index].category.color,
                    ),
                    trailing: Text(_groceryItems[index].quantity.toString())),
              ));
    } else if (isLoading) {
      body = const Center(child: CircularProgressIndicator());
    } else {
      body = Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(error ? 'Failed to fetch data' : 'No grocery list currenctly',
                style: const TextStyle(fontSize: 20).copyWith(
                    color: Theme.of(context).colorScheme.onBackground)),
            const SizedBox(height: 16),
            Text(
                error
                    ? 'T ry again later'
                    : 'Add some items in the grocery list',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground))
          ],
        ),
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Grocery List'),
          actions: [
            IconButton(onPressed: _addItem, icon: const Icon(Icons.add))
          ],
        ),
        body: body);
  }

  void _addItem() async {
    final newItem = await Navigator.of(context).push<GroceryItem>(
        MaterialPageRoute(builder: (ctx) => const NewItem()));

    if (newItem == null) return;

    setState(() {
      _groceryItems.add(newItem);
    });
  }

  void _removeItem(GroceryItem item, int index) async {
    setState(() {
      _groceryItems.remove(item);
    });

    final url = Uri.https(
        'shoppinglistflutter-68d83-default-rtdb.firebaseio.com',
        'shoppingList/${item.id}.json');

    final response = await http.delete(url);

    if (response.statusCode >= 400) {
      setState(() {
        _groceryItems.insert(index, item);
      });
    }
  }
}


 

// Column(
//             children: [
//               for (final item in groceryItems)
//                 Row(
//                   children: [
//                     Container(
//                       width: 25,
//                       height: 25,
//                       margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
//                       child: SizedBox(
//                         height: 1,
//                         width: 1,
//                         child: ColoredBox(color: item.category.color),
//                       ),
//                     ),
//                     Container(
//                         margin: const EdgeInsets.fromLTRB(10, 20, 0, 0),
//                         child: Text(item.name,
//                             style: const TextStyle(color: Colors.white))),
//                     Container(
//                         margin: const EdgeInsets.fromLTRB(200, 20, 20, 0),
//                         child: Text(item.quantity.toString(),
//                             style: const TextStyle(color: Colors.white)))
//                   ],
//                 ),
//             ],
//           ),