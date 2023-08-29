import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ExpensesChart extends StatelessWidget {
  const ExpensesChart({super.key, required this.expenses});

  final List<Expense> expenses;

  List<BarChartGroupData> _getBarGroups() {
    // get the total amount spent in each category
    final Map<ExpenseType, double> totalAmountByCategory = {};
    // loop all expense categories
    for (final category in ExpenseType.values) {
      totalAmountByCategory[category] = 0.0;
    }
    for (final expense in expenses) {
      final currentTotal = totalAmountByCategory[expense.category] ?? 0.0;
      totalAmountByCategory[expense.category] = currentTotal + expense.amount;
    }

    // convert to bar chart data
    return totalAmountByCategory.entries.map((entry) {
      return BarChartGroupData(
        x: entry.key.index,
        barRods: [
          BarChartRodData(
            toY: entry.value,
            width: 30,
            borderRadius: BorderRadius.zero,
            color: const Color.fromARGB(255, 106, 47, 127),
          ),
        ],
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.purple[900],
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              final category = ExpenseType.values[group.x.toInt()];
              return BarTooltipItem(
                '${category.name}: ${rod.toY.toStringAsFixed(2)} \$',
                const TextStyle(color: Colors.white),
              );
            },
          ),
        ),
        titlesData: FlTitlesData(
          show: true,
          topTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                return Icon(
                  expenseTypeIcons[ExpenseType.values[value.toInt()]],
                  size: 30,
                );
              },
            ),
          ),
        ),
        gridData: const FlGridData(
          drawVerticalLine: false,
          drawHorizontalLine: true,
        ),
        borderData: FlBorderData(
          show: false,
        ),
        barGroups: _getBarGroups(),
      ),
    );
  }
}
