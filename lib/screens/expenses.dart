import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myspendwise/screens/expense_form.dart';
import 'package:myspendwise/services/hive_service.dart';
import 'package:myspendwise/widgets/expense_card.dart';
import '../config/app_colors.dart';
import '../data/category.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  String selectedCategory = 'All';
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: HiveService.box.listenable(),
      builder: (context, box, _) {
        final expenses = HiveService.getExpenses();
        expenses.sort((a, b) => b.date.compareTo(a.date));
        final filtered = selectedCategory == 'All'
            ? expenses
            : expenses.where((e) => e.category == selectedCategory).toList();
        double total = expenses.fold(0.0, (sum, e) => sum + e.price);

        return Scaffold(
          backgroundColor: AppColors.background,
          body: CustomScrollView(
            slivers: [
              // Header
              SliverToBoxAdapter(
                child: Container(
                  height: 200,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.accent, AppColors.primary],
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.elliptical(300, 80),
                      bottomRight: Radius.elliptical(300, 80),
                    ),
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        const SizedBox(height: 26),
                        const Text(
                          'TOTAL SPENT THIS MONTH',
                          style: TextStyle(
                            color: AppColors.background,
                            fontSize: 12,
                            letterSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'PKR ${total.toStringAsFixed(0)}',
                          style: const TextStyle(
                            color: AppColors.background,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          margin: const EdgeInsets.only(top: 7),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.background,
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(
                              color: AppColors.accent,
                              width: 1.5,
                            ),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: selectedCategory,
                              isDense: true,
                              menuMaxHeight: 300,
                              icon: const Icon(
                                Icons.keyboard_arrow_down,
                                color: AppColors.accent,
                                size: 18,
                              ),
                              dropdownColor: AppColors.accentLight,
                              style: const TextStyle(
                                color: AppColors.background,
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                              items: [
                                const DropdownMenuItem(
                                  value: 'All',
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.grid_view_rounded,
                                        color: AppColors.accent,
                                        size: 18,
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        'All',
                                        style: TextStyle(
                                          color: AppColors.textPrimary,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                ...categoryMap.entries.map((entry) {
                                  final cat = entry.value;
                                  return DropdownMenuItem(
                                    value: cat.name,
                                    child: Row(
                                      children: [
                                        Icon(
                                          cat.icon,
                                          color: cat.color,
                                          size: 18,
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          cat.name,
                                          style: const TextStyle(
                                            color: AppColors.textPrimary,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                              ],
                              onChanged: (value) {
                                setState(() => selectedCategory = value!);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Expense list
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final expense = filtered[index];
                  return ExpenseCard(
                    expense: expense,
                    onEdit: () => showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (_) => ExpenseForm(expense: expense),
                    ),
                    onDelete: () =>
                        HiveService.deleteExpense(filtered[index].id),
                  );
                }, childCount: filtered.length),
              ),
            ],
          ),
        );
      },
    );
  }
}
