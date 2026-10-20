import 'package:flutter/material.dart';

import 'expenses.dart';
import 'screen/statistics_screen.dart';
import 'screen/setting_screen.dart';
import 'screen/about_screen.dart';

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
      ),

      routes: {
        '/statistics': (context) =>
            const StatisticsScreen(),
        '/settings': (context) =>
            const SettingsScreen(),
        '/about': (context) =>
            const AboutScreen(),
      },

      home: const Expenses(),
    );
  }
}