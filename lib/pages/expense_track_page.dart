import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pocket_pal/providers/expense_provider.dart';
import 'package:pocket_pal/pages/expense_add_sheet.dart';

class ExpenseTrackPage extends StatelessWidget {
  const ExpenseTrackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(0, 0, 0, 0),
      appBar: AppBar(
        title: const Text(
          'Recent Spendings',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Arcade',
            fontSize: 30,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 49, 2, 65),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Consumer<ExpenseProvider>(
            builder: (context, provider, child) {
              return Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Total: \$${provider.totalExpenses.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Consumer<ExpenseProvider>(
              builder: (context, provider, child) {
                final expenses = provider.expenses;
                if (expenses.isEmpty) {
                  return const Center(
                    child: Text(
                      'No expenses yet!',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: expenses.length,
                  itemBuilder: (context, index) {
                    final expense = expenses[index];
                    return _buildExpenseCard(
                      expense.description,
                      expense.category,
                      expense.category == 'Income' 
                          ? '-\$${expense.amount.toStringAsFixed(2)}'
                          : '\$${expense.amount.toStringAsFixed(2)}',
                      expense.icon,
                      expense.color,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Transform.scale(
        scale: 1.2,
        child: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.grey[900],
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
              ),
              builder: (BuildContext context) => const ExpenseBottomSheet(),
            );
          },
          backgroundColor: const Color.fromARGB(255, 106, 34, 131),
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildExpenseCard(
    String description,
    String category,
    String amount,
    IconData icon,
    Color color,
  ) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      color: Colors.grey[850],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    description,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    category,
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              amount,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}