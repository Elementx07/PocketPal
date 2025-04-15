import 'package:flutter/material.dart';

class Expense {
  final String id;
  final String description;
  final String category;
  final double amount;
  final IconData icon;
  final Color color;
  final DateTime date;

  Expense({
    required this.id,
    required this.description,
    required this.category,
    required this.amount,
    required this.icon,
    required this.color,
    required this.date,
  });
}