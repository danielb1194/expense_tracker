import 'package:expense_tracker/data/expenses.dart';
import 'package:flutter/material.dart';

import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses/new_expense.dart';
import 'package:expense_tracker/widgets/expenses/expenses_chart.dart';
import 'package:expense_tracker/widgets/expenses/expenses_list.dart';

class ExpensesView extends StatefulWidget {
  const ExpensesView({super.key});

  @override
  State<StatefulWidget> createState() => _ExpensesViewState();
}

class _ExpensesViewState extends State<ExpensesView> {
  void _addExpense(Expense expense) {
    setState(() {
      expenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    setState(() {
      expenses.remove(expense);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Expense removed'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () => _addExpense(expense),
        ),
      ),
    );
  }

  Widget get _expensesListOrEmpty {
    if (expenses.isEmpty) {
      return const Center(
        child: Text('Nothing to show'),
      );
    }
    return ExpensesList(
      expenses: expenses,
      onRemoveExpense: _removeExpense,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Expense Tracker'),
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (ctx) => CreateExpense(onAddExpense: _addExpense),
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 50),
              child: ExpensesChart(
                expenses: expenses,
              ),
            ),
          ),
          Expanded(
            child: _expensesListOrEmpty,
          ),
        ],
      ),
    );
  }
}
