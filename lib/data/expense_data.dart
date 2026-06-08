import 'package:hive/hive.dart';

part 'expense_data.g.dart';

@HiveType(typeId: 0)
class Expense extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  double price;

  @HiveField(3)
  String category;

  @HiveField(4)
  DateTime date;

  Expense({
    required this.id,
    required this.title,
    required this.price,
    required this.category,
    required this.date,
  });
}
