import 'package:flutter/material.dart';

class Expenses extends StatelessWidget {
  const Expenses({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
      ),
      body: const Center(
        child: Text(
          'No expenses yet.',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
