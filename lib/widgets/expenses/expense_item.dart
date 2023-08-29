import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: expense.icon,
      title: Text(expense.title),
      subtitle: Text('${expense.formattedDate}'),
      trailing: Text('${expense.amount.toStringAsFixed(2)} \$'),
    );
  }
}
