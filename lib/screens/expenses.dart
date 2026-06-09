import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myspendwise/screens/expense_form.dart';
import 'package:myspendwise/services/hive_service.dart';
import 'package:myspendwise/widgets/expense_card.dart';
import '../config/app_colors.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: HiveService.box.listenable(),
      builder: (context, box, _) {
        final expenses = HiveService.getExpenses();
        double total = expenses.fold(0.0, (sum, e) => sum + e.price);
        return Scaffold(
          backgroundColor: AppColors.background,
          body: Column(
            children: [
              Container(
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
                          color: Colors.white,
                          fontSize: 12,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'PKR ${total.toStringAsFixed(0)}',

                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Card(
                        color: Color.fromARGB(
                          255,
                          92,
                          142,
                          223,
                        ), // lighter ocean blue
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          child: Text(
                            '5% increase from last month',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: expenses.length,
                  itemBuilder: (context, index) {
                    final expense = expenses[index];
                    return ExpenseCard(
                      expense: expense,
                      onEdit: () => {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (_) => ExpenseForm(expense: expense),
                        ),
                      },
                      onDelete: () => {
                        HiveService.deleteExpense(expenses[index].id),
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
