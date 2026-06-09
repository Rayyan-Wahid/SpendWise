import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myspendwise/config/app_colors.dart';
import 'package:myspendwise/data/category.dart';
import 'package:myspendwise/data/expense_data.dart';
import 'package:myspendwise/services/hive_service.dart';

class ExpenseForm extends StatefulWidget {
  final Expense? expense;
  const ExpenseForm({super.key, required this.expense});

  @override
  State<ExpenseForm> createState() => ExpenseFormState();
}

class ExpenseFormState extends State<ExpenseForm> {
  late final titleController;
  late final priceController;

  late String selectedCategory;
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(
      text: widget.expense != null ? widget.expense!.title : '',
    );
    priceController = TextEditingController(
      text: widget.expense != null ? widget.expense!.price.toString() : '',
    );

    selectedCategory = widget.expense != null
        ? widget.expense!.category
        : 'Food';
    selectedDate = widget.expense != null
        ? widget.expense!.date
        : DateTime.now();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      setState(() => selectedDate = picked);
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      decoration: const BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Container(
                width: 36,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),

            const Text(
              'Add Expense',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),

            const SizedBox(height: 16),

            _label('Title'),
            _input(titleController, 'e.g. Dinner with friends'),

            const SizedBox(height: 12),

            _label('Price'),
            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: _inputDecoration('0').copyWith(prefixText: 'PKR  '),
            ),

            const SizedBox(height: 12),

            _label('Category'),
            const SizedBox(height: 6),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: categoryMap.keys.map((cat) {
                  final selected = cat == selectedCategory;

                  return GestureDetector(
                    onTap: () => setState(() => selectedCategory = cat),
                    child: Container(
                      width: 70,
                      height: 70,
                      margin: const EdgeInsets.all(7),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: selected
                            ? categoryMap[cat]!.color.withOpacity(0.15)
                            : AppColors.textMuted.withOpacity(0.08),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            categoryMap[cat]!.icon,
                            color: selected
                                ? categoryMap[cat]!.color
                                : AppColors.textMuted,
                            size: 25,
                          ),
                          Text(
                            categoryMap[cat]!.name,
                            style: TextStyle(
                              fontSize: 10,
                              color: selected
                                  ? categoryMap[cat]!.color
                                  : AppColors.textMuted,
                              letterSpacing: -0.4,
                              fontWeight: selected
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 12),

            _label('Date'),
            GestureDetector(
              onTap: _pickDate,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 13,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: AppColors.inputFill,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.inputBorder),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(DateFormat('dd MMM yyyy').format(selectedDate)),
                    const Icon(Icons.calendar_today_outlined, size: 16),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 12),

            const SizedBox(height: 20),

            SizedBox(
              height: 48,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    saveData();
                    titleController.clear();
                    priceController.clear();
                    selectedCategory = 'Food';
                    selectedDate = DateTime.now();
                    if (widget.expense != null) Navigator.pop(context);
                  });
                  ();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: widget.expense != null
                          ? Text("Expense updated successfully")
                          : Text("Expense added successfully"),
                      backgroundColor: AppColors.accent,
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 2,
                ),
                child: const Text('Save expense'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _label(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 5),
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: AppColors.textMuted,
      ),
    ),
  );

  Widget _input(TextEditingController c, String hint) =>
      TextField(controller: c, decoration: _inputDecoration(hint));

  InputDecoration _inputDecoration(String hint) => InputDecoration(
    hintText: hint,
    filled: true,
    fillColor: AppColors.inputFill,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
  );

  Future<void> saveData() async {
    final existing = widget.expense;
    if (existing != null) {
      await HiveService.addExpense(
        Expense(
          id: existing.id,
          title: titleController.text,
          price: double.parse(priceController.text),
          category: selectedCategory,
          date: selectedDate,
        ),
      );
    } else {
      await HiveService.addExpense(
        Expense(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          title: titleController.text,
          price: double.parse(priceController.text),
          category: selectedCategory,
          date: selectedDate,
        ),
      );
    }
  }
}
