import 'package:expense_tracker/models/expense.dart';

final List<Expense> expenses = [
  // dummy data
  Expense(
    title: 'Groceries',
    amount: 100.00,
    date: DateTime.now(),
    category: ExpenseType.food,
  ),
  Expense(
    title: 'New Phone',
    amount: 1000.00,
    date: DateTime.now(),
    category: ExpenseType.other,
  ),
  Expense(
    title: 'New Laptop',
    amount: 5000.00,
    date: DateTime.now(),
    category: ExpenseType.other,
  ),
];
