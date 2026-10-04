import 'package:flutter/material.dart';
import '../expense.dart';
import 'expense_item.dart';

class ExpenseList extends StatelessWidget {
  final List<Expense> expenses;
  final void Function(int index) onDelete;

  const ExpenseList({
    super.key,
    required this.expenses,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    if (expenses.isEmpty) {
      return const Center(
        child: Text(
          'No expenses yet.\nStart tracking your spending!',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      );
    }

    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) {
        return ExpenseItem(
          expense: expenses[index],
          onDelete: () => onDelete(index),
        );
      },
    );
  }
}