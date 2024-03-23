import 'package:first_app/expense/expenseMain.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();

enum Category {
  work,
  entertainment
}

final formatter =DateFormat.yMd();

const categoryIcons = {
  Category.work: Icons.work,
  Category.entertainment: Icons.holiday_village
};

class ExpenseData {

  ExpenseData({
    required this.title, 
    required this.amount, 
    required this.date,
    required this.category,
    }): id = uuid.v4();
  
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formatteDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  const ExpenseBucket({required this.category, required this.expenses});

  ExpenseBucket.forCategory(List<ExpenseData> allExpense, this.category) : expenses = allExpense.where((expense) => expense.category == category).toList();

  final Category category;
  final List<ExpenseData> expenses;

  double get totalExpenses {
    double sum = 0;

    for (final expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}