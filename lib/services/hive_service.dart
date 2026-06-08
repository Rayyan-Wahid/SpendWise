import 'package:hive/hive.dart';
import '../data/expense_data.dart';

class HiveService {
  static Box<Expense> get box => Hive.box<Expense>('expenses');

  static Future<void> addExpense(Expense expense) async {
    await box.put(expense.id, expense);
  }

  static List<Expense> getExpenses() {
    return box.values.toList();
  }

  static Future<void> deleteExpense(String id) async {
    await box.delete(id);
  }
}
