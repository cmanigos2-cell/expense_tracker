import 'package:flutter/material.dart';

import '../expense.dart';

class ExpenseForm extends StatefulWidget {
  final TextEditingController titleController;
  final TextEditingController amountController;

  final Category selectedCategory;

  final ValueChanged<Category?> onCategoryChanged;

  final VoidCallback onAddExpense;

  const ExpenseForm({
    super.key,
    required this.titleController,
    required this.amountController,
    required this.selectedCategory,
    required this.onCategoryChanged,
    required this.onAddExpense,
  });

  @override
  State<ExpenseForm> createState() {
    return _ExpenseFormState();
  }
}

class _ExpenseFormState extends State<ExpenseForm> {
  DateTime? _selectedDate;

  Future<void> _selectDate() async {
    final now = DateTime.now();

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: DateTime(
        now.year - 1,
        now.month,
        now.day,
      ),
      lastDate: DateTime(
        now.year + 1,
        now.month,
        now.day,
      ),
    );

    if (pickedDate == null) {
      return;
    }

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _cancelForm() {
    widget.titleController.clear();
    widget.amountController.clear();

    setState(() {
      _selectedDate = null;
    });
  }

  String _formatDate(DateTime date) {
    return '${date.month.toString().padLeft(2, '0')}/'
        '${date.day.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Add New Expense',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            // EXPENSE TITLE
            TextField(
              controller: widget.titleController,
              maxLength: 50,
              decoration: const InputDecoration(
                labelText: 'Expense Title',
                hintText: 'Example: Lunch',
                prefixIcon: Icon(
                  Icons.title,
                ),
              ),
            ),

            const SizedBox(height: 8),

            // AMOUNT
            TextField(
              controller: widget.amountController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Amount',
                hintText: 'Example: 150',
                prefixText: '₱ ',
                prefixIcon: Icon(
                  Icons.payments,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // CATEGORY
            DropdownButtonFormField<Category>(
              initialValue: widget.selectedCategory,
              decoration: const InputDecoration(
                labelText: 'Category',
                prefixIcon: Icon(
                  Icons.category,
                ),
              ),
              items: const [
                DropdownMenuItem(
                  value: Category.food,
                  child: Text('Food'),
                ),
                DropdownMenuItem(
                  value: Category.travel,
                  child: Text('Travel'),
                ),
                DropdownMenuItem(
                  value: Category.leisure,
                  child: Text('Leisure'),
                ),
                DropdownMenuItem(
                  value: Category.work,
                  child: Text('Work'),
                ),
              ],
              onChanged: widget.onCategoryChanged,
            ),

            const SizedBox(height: 16),

            // DATE
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: _selectDate,
                icon: const Icon(
                  Icons.calendar_month,
                ),
                label: Text(
                  _selectedDate == null
                      ? 'Choose Date'
                      : _formatDate(_selectedDate!),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // BUTTONS
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: _cancelForm,
                  child: const Text(
                    'Cancel',
                  ),
                ),

                const SizedBox(width: 8),

                ElevatedButton.icon(
                  onPressed: () {
                    final title =
                        widget.titleController.text.trim();

                    final amount = double.tryParse(
                      widget.amountController.text.trim(),
                    );

                    if (title.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Please enter an expense title.',
                          ),
                        ),
                      );
                      return;
                    }

                    if (amount == null || amount <= 0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Please enter a valid amount.',
                          ),
                        ),
                      );
                      return;
                    }

                    if (_selectedDate == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Please choose a date.',
                          ),
                        ),
                      );
                      return;
                    }

                    widget.onAddExpense();

                    setState(() {
                      _selectedDate = null;
                    });
                  },
                  icon: const Icon(
                    Icons.add,
                  ),
                  label: const Text(
                    'Add Expense',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}