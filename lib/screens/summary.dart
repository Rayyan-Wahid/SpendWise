import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myspendwise/data/category.dart';
import 'package:myspendwise/data/expense_data.dart';
import 'package:myspendwise/services/hive_service.dart';
import 'package:myspendwise/widgets/summary_card.dart';
import '../config/app_colors.dart';

class SummaryScreen extends StatefulWidget {
  const SummaryScreen({super.key});

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  final labels = categoryMap.keys.toList();

  static const Map<String, String> shortLabels = {
    'Food': 'Food',
    'Transport': 'Trans.',
    'Utilities': 'Utils.',
    'Shopping': 'Shop.',
    'Health': 'Health',
    'Other': 'Other',
  };

  List<BarChartGroupData> buildBars(Map<String, double> totals) {
    return List.generate(labels.length, (index) {
      final value = totals[labels[index]] ?? 0.0;
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: value,
            width: MediaQuery.of(context).size.width * 0.09,

            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            color: AppColors.primary,
          ),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: HiveService.box.listenable(),
      builder: (context, value, child) {
        final expenses = HiveService.getExpenses();
        final total = categoryTotals(expenses);
        final double maximumTotal = total.values.isEmpty
            ? 1.0
            : total.values.fold(0.0, (a, b) => a > b ? a : b);
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(12, 24, 12, 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 20,
                        color: Colors.black.withOpacity(0.05),
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: SizedBox(
                    height: 220,
                    child: BarChart(
                      BarChartData(
                        alignment: BarChartAlignment.spaceAround,
                        maxY:
                            (total.values.isEmpty
                                ? 100
                                : total.values.reduce(
                                    (a, b) => a > b ? a : b,
                                  )) *
                            1.25, // headroom above tallest bar
                        barGroups: buildBars(total),
                        titlesData: FlTitlesData(
                          // Hide left, right, top axes
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          rightTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          topTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          // Category labels at the bottom
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 40,
                              getTitlesWidget: (value, meta) {
                                final index = value.toInt();
                                if (index < 0 || index >= labels.length) {
                                  return const SizedBox.shrink();
                                }
                                return Padding(
                                  padding: const EdgeInsets.only(top: 6),
                                  child: Text(
                                    shortLabels[labels[index]] ?? labels[index],
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: AppColors.textMuted,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        borderData: FlBorderData(show: false),
                        gridData: FlGridData(
                          show: false,
                        ), // clean, no grid lines
                        barTouchData: BarTouchData(enabled: false),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Category Breakdown',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: labels.length,
                    itemBuilder: (context, index) {
                      final label = labels[index];
                      final double categoryTotal = total[label] ?? 0.0;
                      return SummaryCard(
                        total: categoryTotal,
                        category: categoryMap[label]!,
                        maximum: maximumTotal,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Map<String, double> categoryTotals(List<Expense> expenses) {
  final Map<String, double> totals = {
    for (final key in categoryMap.keys) key: 0.0,
  };

  for (final expense in expenses) {
    totals.update(expense.category, (value) => value + expense.price);
  }

  return totals;
}
