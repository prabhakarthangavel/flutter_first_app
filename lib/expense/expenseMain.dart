import 'package:first_app/expense/expenseList.dart';
import 'package:first_app/expense/newExpense.dart';
import 'package:first_app/models/expenseData.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _Expenses();
  }
}

class _Expenses extends State<Expenses> {
  final List<ExpenseData> _registeredExpense = [
    ExpenseData(
        title: 'Cinema',
        amount: 250,
        date: DateTime.now(),
        category: Category.entertainment),
    ExpenseData(
        title: 'Lunch',
        amount: 500,
        date: DateTime.now(),
        category: Category.entertainment)
  ];

  @override
  Widget build(Object context) {
    Widget mainContent = const Center(child: Text('No expense found, start addding some'));

    if (!_registeredExpense.isEmpty) {
      mainContent = ExpenseList(expense: _registeredExpense, onRemoveExpense: _removeExpense);
    }

    return Scaffold(
        appBar: AppBar(title: const Text('Expense Tracker'), actions: [
          IconButton(onPressed: _openAddOverlay, icon: const Icon(Icons.add))
        ]),
        body: Column(children: [
          const Text('The chart'),
          Expanded(child: mainContent)
        ]));
  }

  void _openAddOverlay() {
    showModalBottomSheet(isScrollControlled: true, context: context, builder: (cts) => NewExpense(onAddExpense: _addExpense));
  }

  void _addExpense(ExpenseData expense) {
    setState(() {
      _registeredExpense.add(expense);
    });
  }

  void _removeExpense(int index) {
    ExpenseData expense = _registeredExpense[index];
    String expenseName = expense.title;
    setState(() {
      _registeredExpense.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$expenseName expense deleted'),
    action: SnackBarAction(label: 'Undo', onPressed: () {
      setState(() {
        _registeredExpense.insert(index, expense);
      });
    })));
  }
}
