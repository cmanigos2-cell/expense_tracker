import 'package:flutter/material.dart';

import '/expense.dart';
import 'widgets/expense_form.dart';
import 'widgets/expense_list.dart';
import 'widgets/total_expenses.dart';

void main() {
  runApp(const ExpenseTrackerApp());
}

class ExpenseTrackerApp extends StatelessWidget {
  const ExpenseTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense Tracker',

      theme: ThemeData(
        useMaterial3: true,

        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          brightness: Brightness.light,
        ),

        appBarTheme: const AppBarTheme(
          centerTitle: true,
        ),

        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),

        cardTheme: const CardThemeData(
          elevation: 3,
          margin: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
        ),
      ),

      home: const ExpenseHomePage(),
    );
  }
}

class ExpenseHomePage extends StatefulWidget {
  const ExpenseHomePage({super.key});

  @override
  State<ExpenseHomePage> createState() {
    return _ExpenseHomePageState();
  }
}

class _ExpenseHomePageState extends State<ExpenseHomePage> {
  final TextEditingController _titleController =
      TextEditingController();

  final TextEditingController _amountController =
      TextEditingController();

  final List<Expense> _expenses = [];

  Category _selectedCategory = Category.food;

  double get _totalExpenses {
    return _expenses.fold(
      0,
      (sum, expense) => sum + expense.amount,
    );
  }

  void _addExpense() {
    final title = _titleController.text.trim();

    final amount = double.tryParse(
      _amountController.text,
    );

    if (title.isEmpty || amount == null || amount <= 0) {
      return;
    }

    setState(() {
      _expenses.add(
        Expense(
          title: title,
          amount: amount,
          date: DateTime.now(),
          category: _selectedCategory,
        ),
      );
    });

    _titleController.clear();
    _amountController.clear();
  }

  void _deleteExpense(int index) {
    setState(() {
      _expenses.removeAt(index);
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Expense Tracker',
        ),
      ),

      body: OrientationBuilder(
        builder: (context, orientation) {
          // LANDSCAPE
          if (orientation == Orientation.landscape) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TotalExpenses(
                          total: _totalExpenses,
                        ),

                        ExpenseForm(
                          titleController: _titleController,
                          amountController: _amountController,
                          selectedCategory: _selectedCategory,
                          onCategoryChanged: (value) {
                            if (value == null) {
                              return;
                            }

                            setState(() {
                              _selectedCategory = value;
                            });
                          },
                          onAddExpense: _addExpense,
                        ),
                      ],
                    ),
                  ),
                ),

                Expanded(
                  flex: 3,
                  child: ExpenseList(
                    expenses: _expenses,
                    onDelete: _deleteExpense,
                  ),
                ),
              ],
            );
          }

          // PORTRAIT
          return Column(
            children: [
              TotalExpenses(
                total: _totalExpenses,
              ),

              ExpenseForm(
                titleController: _titleController,
                amountController: _amountController,
                selectedCategory: _selectedCategory,
                onCategoryChanged: (value) {
                  if (value == null) {
                    return;
                  }

                  setState(() {
                    _selectedCategory = value;
                  });
                },
                onAddExpense: _addExpense,
              ),

              const SizedBox(
                height: 10,
              ),

              Expanded(
                child: ExpenseList(
                  expenses: _expenses,
                  onDelete: _deleteExpense,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}