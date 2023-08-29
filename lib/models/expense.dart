import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

final DateFormat _dateFormat = DateFormat.yMd();

const Uuid _uuid = Uuid();

enum ExpenseType { food, travel, work, other }

const Map<ExpenseType, IconData> expenseTypeIcons = {
  ExpenseType.food: Icons.fastfood,
  ExpenseType.travel: Icons.flight,
  ExpenseType.work: Icons.work,
  ExpenseType.other: Icons.category,
};

class Expense {
  final String title;
  final double amount;
  final DateTime date;
  final ExpenseType category;
  final String id = _uuid.v4();

  get icon => Icon(expenseTypeIcons[category]);
  get formattedDate => _dateFormat.format(date);

  Expense({
    required this.title,
    required this.amount,
    required this.date,
    this.category = ExpenseType.other,
  });
}
