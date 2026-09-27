import 'package:flutter/material.dart';

enum Category {
  food,
  travel,
  leisure,
  work,
}

class Expense {
  const Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  });

  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDate {
    return '${date.month}/${date.day}/${date.year}';
  }

  IconData get categoryIcon {
    switch (category) {
      case Category.food:
        return Icons.restaurant;
      case Category.travel:
        return Icons.flight;
      case Category.leisure:
        return Icons.movie;
      case Category.work:
        return Icons.work;
    }
  }
}
