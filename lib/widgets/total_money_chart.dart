import 'package:flutter/material.dart';
import 'package:alt_expense_tracker_app/models/expense.dart';

class TotalMoneyChart extends StatelessWidget {
  const TotalMoneyChart({super.key, required this.totalAmount});

  final num totalAmount;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(24, 16, 24, 0),

      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: const LinearGradient(
          colors: [Color(0xFF158540), Color(0xFF20BE5A)],
          end: Alignment.topLeft,
          begin: Alignment.bottomRight,
        ),
      ),
      child:  Text(
        "Total Money Spend:\n${currencyFormatter.format(totalAmount)}",
        style: const TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
