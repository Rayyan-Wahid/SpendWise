import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myspendwise/data/category.dart';
import 'package:myspendwise/data/expense_data.dart';
import 'package:myspendwise/widgets/expense_card.dart';
import '../config/app_colors.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  List<Expense> expenses = List.from(mockExpenses);
  List<Expense> get sorted =>
      [...expenses]..sort((a, b) => b.date.compareTo(a.date));

  double get total => expenses.fold(0, (sum, e) => sum + e.price);

  @override
  Widget build(BuildContext context) {
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
                  SizedBox(height: 26),
                  Text(
                    'TOTAL SPENT THIS MONTH',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      letterSpacing: 1.5,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'PKR ${total.toStringAsFixed(0)}',

                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.5,
                    ),
                  ),
                  SizedBox(height: 16),
                  Card(
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
              itemCount: sorted.length,
              itemBuilder: (context, index) {
                final expense = sorted[index];
                return ExpenseCard(
                  expense: expense,
                  onEdit: () => {},
                  onDelete: () => {},
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
