import 'package:first_app/models/expenseData.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expenseData, {super.key});

  final ExpenseData expenseData;

  @override
  Widget build(Object context) {
    return Card(child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        children: [
          Text(expenseData.title),
          const SizedBox(height: 4),
          Row(
            children: [
              Text('\$${expenseData.amount.toStringAsFixed(2)}'),
              const Spacer(),
              Row(children: [
                const Icon(Icons.alarm),
                const SizedBox(width: 8),
                Text(expenseData.date.toString())
              ])
            ],
          )
        ],)
    ));
  }

}