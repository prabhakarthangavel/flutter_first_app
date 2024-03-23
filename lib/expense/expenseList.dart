import 'package:first_app/expense/expenseItem.dart';
import 'package:first_app/models/expenseData.dart';
import 'package:flutter/material.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({required this.expense, super.key, required this.onRemoveExpense});
  final void Function(int index) onRemoveExpense;

  final List<ExpenseData> expense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: expense.length,
        itemBuilder: (ctx, index) => Dismissible(
          background: Container(color: Color.fromRGBO(238, 229, 229, 0.808)),
          onDismissed: (direction) {
            onRemoveExpense(index);
          },
            key: ValueKey(expense[index]), child: ExpenseItem(expense[index])));
  }
}
