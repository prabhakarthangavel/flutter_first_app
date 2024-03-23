import 'package:first_app/shoppingListApp/data/categories.dart';
import 'package:first_app/shoppingListApp/data/dummy_items.dart';
import 'package:first_app/shoppingListApp/models/grocery_item.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewItem extends StatefulWidget {
  const NewItem({super.key});

  @override
  State<NewItem> createState() => _NewItemState();
}

class _NewItemState extends State<NewItem> {
  final _formKey = GlobalKey<FormState>();
  var _enteredName = '';
  var _enteredQuantity = 1;
  var _selectedCategory = categories[Categories.vegetables]!;
  var isSubmitting = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Add a new item')),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Form(
              key: _formKey,
              child: Column(children: [
                TextFormField(
                  maxLength: 50,
                  decoration: const InputDecoration(label: Text('Name')),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.trim().length <= 1 ||
                        value.trim().length > 50) {
                      return 'Must be 1 to 50 characters.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _enteredName = value!;
                  },
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: TextFormField(
                          decoration:
                              const InputDecoration(label: Text('Quantity')),
                          keyboardType: TextInputType.number,
                          initialValue: _enteredQuantity.toString(),
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                int.tryParse(value) == null ||
                                int.tryParse(value)! <= 0) {
                              return 'Must be valid positive number';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _enteredQuantity = int.parse(value!);
                          }),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: DropdownButtonFormField(
                          value: _selectedCategory,
                          items: [
                            for (final categroy in categories.entries)
                              DropdownMenuItem(
                                  value: categroy.value,
                                  child: Row(children: [
                                    Container(
                                        width: 16,
                                        height: 16,
                                        color: categroy.value.color),
                                    const SizedBox(width: 6),
                                    Text(categroy.value.name)
                                  ]))
                          ],
                          onChanged: (value) {
                            setState(() {
                              _selectedCategory = value!;
                            });
                            ;
                          }),
                    )
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: isSubmitting
                            ? null
                            : () {
                                _formKey.currentState!.reset();
                              },
                        child: const Text('Resst')),
                    ElevatedButton(
                        onPressed: isSubmitting ? null : _addItem,
                        child: isSubmitting
                            ? const SizedBox(height: 16, width: 16)
                            : const Text('Add Item'))
                  ],
                )
              ])),
        ));
  }

  void _addItem() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        isSubmitting = true;
      });
      final url = Uri.https(
          'shoppinglistflutter-68d83-default-rtdb.firebaseio.com',
          'shoppingList.json');
      final response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
          },
          body: json.encode({
            'name': _enteredName,
            'quantity': _enteredQuantity,
            'category': _selectedCategory.name
          }));

      final Map<String, dynamic> resData = json.decode(response.body);
      setState(() {
        isSubmitting = false;
      });
      if (!context.mounted) return;

      Navigator.of(context).pop(GroceryItem(
          id: resData['name'],
          name: _enteredName,
          quantity: _enteredQuantity,
          category: _selectedCategory));
    }
  }
}
