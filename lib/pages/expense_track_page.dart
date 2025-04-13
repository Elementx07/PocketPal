import 'package:flutter/material.dart';
import 'package:pocket_pal/pages/expense_add_sheet.dart';

class ExpenseTrackPage extends StatelessWidget {
  const ExpenseTrackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
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
      //sized box for some space
      
      body: Column(
        children: [
          const SizedBox(height: 20),
          const RecentSpendings(),
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
}

class RecentSpendings extends StatelessWidget {
  const RecentSpendings({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            _buildExpenseCard(
              'Zomato Order',
              'Food',
              '\$25.99',
              Icons.restaurant,
              Colors.pink[100]!,
            ),
            _buildExpenseCard(
              'Amazon Order',
              'Shopping',
              '\$149.99',
              Icons.shopping_bag,
              Colors.purple[200]!,
            ),
            _buildExpenseCard(
              'Netflix Subscription',
              'Entertainment',
              '\$14.99',
              Icons.sports_esports,
              Colors.orange[200]!,
            ),
            _buildExpenseCard(
              'Electricity Bill',
              'Bills',
              '\$85.50',
              Icons.bolt,
              Colors.yellow[600]!,
            ),
            _buildExpenseCard(
              'Phone Bill',
              'Bills',
              '\$45.00',
              Icons.phone_android,
              Colors.blue[300]!,
            ),
          ],
        ),
      ],
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