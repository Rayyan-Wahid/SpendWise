import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myspendwise/config/app_colors.dart';
import 'package:myspendwise/screens/expense_form.dart';
import 'package:myspendwise/screens/expenses.dart';
import 'package:myspendwise/screens/summary.dart';
import 'package:myspendwise/services/hive_service.dart';

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: HiveService.box.listenable(),
      builder: (context, box, _) {
        final expenses = HiveService.getExpenses();
        final screens = [
          ExpensesScreen(expenses: expenses),
          const ExpenseForm(expense: null),
          SummaryScreen(expenses: expenses),
        ];

        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'SpendWise',
                  style: TextStyle(
                    color: AppColors.background,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.5,
                  ),
                ),
              ],
            ),

            backgroundColor: Colors.transparent,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.accent, AppColors.primary],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            elevation: 0,
          ),
          body: screens[index],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: index,
            onTap: (i) => setState(() => index = i),

            backgroundColor: AppColors.surface,
            selectedItemColor: AppColors.accent,
            unselectedItemColor: AppColors.textMuted,
            showUnselectedLabels: true,
            items: [
              const BottomNavigationBarItem(
                icon: Icon(Icons.receipt_long),
                activeIcon: Icon(Icons.receipt_long_outlined),
                label: 'Expenses',
              ),
              BottomNavigationBarItem(
                icon: Image.asset('images/add (1).png', width: 24, height: 24),
                activeIcon: Image.asset(
                  'images/icon_add.png',
                  width: 24,
                  height: 24,
                ),
                label: 'Add',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.bar_chart),
                label: 'Summary',
              ),
            ],
          ),
        );
      },
    );
  }
}
