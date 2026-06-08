import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../config/app_colors.dart';
import '../data/expense_data.dart';
import '../data/category.dart';

class SummaryCard extends StatelessWidget {
  final double total;
  final Category category;
  final double maximum;

  const SummaryCard({
    super.key,
    required this.total,
    required this.category,
    required this.maximum,
  });

  @override
  Widget build(BuildContext context) {
    final ratio = maximum > 0 ? (total / maximum).clamp(0.0, 1.0) : 0.0;

    return Card(
      elevation: 3,
      shadowColor: Colors.black26,
      margin: const EdgeInsets.symmetric(vertical: 6),
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // Icon
            Container(
              width: 46,
              height: 46,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: category.color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(category.icon, color: category.color, size: 22),
            ),
            const SizedBox(width: 12),
            // Name + amount + progress bar
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min, // 👈 key fix
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        category.name,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        'PKR ${total.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // 👇 No Expanded here — just a fixed height SizedBox
                  SizedBox(
                    height: 6,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: ratio,
                        backgroundColor: category.color.withOpacity(0.1),
                        valueColor: AlwaysStoppedAnimation<Color>(
                          category.color,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
