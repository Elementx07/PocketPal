import 'package:flutter/material.dart';
import 'package:pocket_pal/widgets/game_mode_text.dart'; // arcadeFont
import 'package:pocket_pal/widgets/cosmos.dart'; // background

class SavingsGoalScreen extends StatelessWidget {
  const SavingsGoalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const CosmosBackground(),
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          Positioned(
            top: 40,
            left: 20,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          Positioned(
            top: 100,
            left: 20,
            right: 20,
            child: Text(
              'Savings Goals',
              style: arcadeFont().copyWith(
                fontSize: 32,
                color: Colors.orangeAccent,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Positioned.fill(
            top: 180,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView(
                padding: const EdgeInsets.only(bottom: 80),
                children: const [
                  SavingsGoalTile(
                    title: 'Spring Break Trip',
                    currentAmount: 350,
                    targetAmount: 500,
                    progress: 0.7,
                    targetDate: 'May 15, 2025',
                    status: 'On track',
                  ),
                  SavingsGoalTile(
                    title: 'New Laptop',
                    currentAmount: 450,
                    targetAmount: 1200,
                    progress: 0.375,
                    targetDate: 'Aug 30, 2025',
                    status: 'Needs attention',
                  ),
                  SavingsGoalTile(
                    title: 'Emergency Fund',
                    currentAmount: 2000,
                    targetAmount: 5000,
                    progress: 0.4,
                    targetDate: 'Dec 31, 2025',
                    status: 'On track',
                  ),
                  SavingsGoalTile(
                    title: 'Vacation to Japan',
                    currentAmount: 1500,
                    targetAmount: 3000,
                    progress: 0.5,
                    targetDate: 'Oct 10, 2025',
                    status: 'On track',
                  ),
                  SavingsGoalTile(
                    title: 'Home Renovation',
                    currentAmount: 10000,
                    targetAmount: 25000,
                    progress: 0.4,
                    targetDate: 'Mar 1, 2026',
                    status: 'Needs attention',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: Colors.black87,
              title: const Text('Add Savings Goal',
                  style: TextStyle(color: Colors.white)),
              content: const Text(
                'This is where you can add a new savings goal.',
                style: TextStyle(color: Colors.white70),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Close',
                      style: TextStyle(color: Colors.greenAccent)),
                ),
              ],
            ),
          );
        },
        backgroundColor: Colors.greenAccent,
        child: const Icon(Icons.add, color: Colors.black),
      ),
    );
  }
}

class SavingsGoalTile extends StatelessWidget {
  final String title;
  final double currentAmount;
  final double targetAmount;
  final double progress;
  final String targetDate;
  final String status;

  const SavingsGoalTile({
    super.key,
    required this.title,
    required this.currentAmount,
    required this.targetAmount,
    required this.progress,
    required this.targetDate,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      color: Colors.black.withOpacity(0.6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title and Amount
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  '₹${currentAmount.toInt()}/₹${targetAmount.toInt()}   ${(progress * 100).toStringAsFixed(1)}%',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.white24,
              color: progress > 0.7 ? Colors.greenAccent : Colors.orangeAccent,
              minHeight: 8,
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Target date: $targetDate',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
                Text(
                  status,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: status == 'On track'
                        ? Colors.greenAccent
                        : Colors.redAccent,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SavingsGoalScreen(),
  ));
}
