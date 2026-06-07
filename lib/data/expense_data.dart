class Expense {
  final String id;
  final String title;
  final double price;
  final String category;
  final DateTime date;

  Expense({
    required this.id,
    required this.title,
    required this.price,
    required this.category,
    required this.date,
  });

  Expense copyWith({
    String? title,
    double? price,
    String? category,
    DateTime? date,
  }) {
    return Expense(
      id: id,
      title: title ?? this.title,
      price: price ?? this.price,
      category: category ?? this.category,
      date: date ?? this.date,
    );
  }
}

List<Expense> mockExpenses = [
  Expense(
    id: '1',
    title: 'Grocery shopping',
    price: 3200,
    category: 'Food',
    date: DateTime(2025, 6, 5),
  ),
  Expense(
    id: '2',
    title: 'Uber to office',
    price: 450,
    category: 'Transport',
    date: DateTime(2025, 6, 4),
  ),
  Expense(
    id: '3',
    title: 'Electricity bill',
    price: 8500,
    category: 'Utilities',
    date: DateTime(2025, 6, 3),
  ),
  Expense(
    id: '4',
    title: 'Pizza night',
    price: 1800,
    category: 'Food',
    date: DateTime(2025, 6, 2),
  ),
  Expense(
    id: '5',
    title: 'Pharmacy',
    price: 1200,
    category: 'Health',
    date: DateTime(2025, 6, 1),
  ),
];
