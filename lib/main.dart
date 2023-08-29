import 'package:expense_tracker/views/expenses_view.dart';
import 'package:flutter/material.dart';

final ThemeData theme = ThemeData().copyWith(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple[900]!),
  useMaterial3: true,
);

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: const ExpensesView(), theme: theme);
  }
}
