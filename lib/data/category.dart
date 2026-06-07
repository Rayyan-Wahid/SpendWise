import 'package:flutter/material.dart';

class Category {
  final String name;
  final IconData icon;
  final Color color;

  Category({required this.name, required this.icon, required this.color});
}

Map<String, Category> categoryMap = {
  'Food': Category(
    name: 'Food',
    color: Color(0xFF059669),
    icon: Icons.shopping_cart_outlined,
  ),
  'Transport': Category(
    name: 'Transport',
    color: Color(0xFF3B82F6),
    icon: Icons.directions_car_outlined,
  ),
  'Utilities': Category(
    name: 'Utilities',
    color: Color(0xFFD97706),
    icon: Icons.bolt_outlined,
  ),
  'Shopping': Category(
    name: 'Shopping',
    color: Color(0xFFEC4899),
    icon: Icons.shopping_bag_outlined,
  ),
  'Health': Category(
    name: 'Health',
    color: Color(0xFFEF4444),
    icon: Icons.favorite_border,
  ),
  'Other': Category(
    name: 'Other',
    color: Color(0xFF6B7280),
    icon: Icons.more_horiz,
  ),
};
