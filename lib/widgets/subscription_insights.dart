import 'package:flutter/material.dart';
import '../models/subscription.dart';

class SubscriptionInsights extends StatelessWidget {
  const SubscriptionInsights({super.key});

  // Static subscription data matching the one from subscription_list_view.dart
  static final List<Subscription> _staticSubscriptions = [
    Subscription(
      id: '1',
      serviceName: 'Netflix',
      plan: 'Premium 4K',
      price: 14.99,
      billingCycle: 'Monthly',
      category: 'Entertainment',
      startDate: DateTime.now(),
      paymentMethod: 'Credit Card',
      paymentDetails: '4582',
    ),
    Subscription(
      id: '2',
      serviceName: 'Spotify',
      plan: 'Family Plan',
      price: 9.99,
      billingCycle: 'Monthly',
      category: 'Music',
      startDate: DateTime.now(),
      paymentMethod: 'PayPal',
      paymentDetails: '7391',
    ),
    Subscription(
      id: '3',
      serviceName: 'Amazon Prime',
      plan: 'Annual Subscription',
      price: 139.99,
      billingCycle: 'Yearly',
      category: 'Shopping',
      startDate: DateTime.now(),
      paymentMethod: 'Debit Card',
      paymentDetails: '9248',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final subscriptions = _staticSubscriptions;
    final categoryTotals = _calculateCategoryTotals(subscriptions);
    final totalAmount = categoryTotals.values.fold(0.0, (a, b) => a + b);

    return Dialog(
      backgroundColor: const Color.fromARGB(255, 49, 2, 65),
      child: Container(
        padding: const EdgeInsets.all(24),
        constraints: const BoxConstraints(maxWidth: 400, maxHeight: 600),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Subscription Insights',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(45, 86, 33, 131),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color.fromARGB(255, 0, 0, 0)),
                ),
                child: subscriptions.isEmpty
                    ? const Center(
                        child: Text(
                          'No subscriptions to analyze',
                          style: TextStyle(color: Colors.white70),
                        ),
                      )
                    : ListView(
                        children: [
                          Text(
                            'Total Monthly Spend: ₹${totalAmount.toStringAsFixed(2)}',
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          ...categoryTotals.entries.map((entry) {
                            final progress = entry.value / totalAmount;
                            return _buildSubscriptionItem(
                              icon: _getCategoryIcon(entry.key),
                              category: entry.key,
                              amount: entry.value,
                              progress: progress,
                              color: _getCategoryColor(entry.key),
                            );
                          }),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Map<String, double> _calculateCategoryTotals(List<Subscription> subscriptions) {
    final categoryTotals = <String, double>{};
    for (final subscription in subscriptions) {
      categoryTotals[subscription.category] = 
          (categoryTotals[subscription.category] ?? 0) + subscription.price;
    }
    return categoryTotals;
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'entertainment':
        return Icons.movie;
      case 'music':
        return Icons.music_note;
      case 'productivity':
        return Icons.work;
      case 'shopping':
        return Icons.shopping_bag;
      default:
        return Icons.subscriptions;
    }
  }

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'entertainment':
        return Colors.purple;
      case 'music':
        return Colors.red;
      case 'productivity':
        return Colors.orange;
      case 'shopping':
        return Colors.green;
      default:
        return Colors.blue;
    }
  }

  Widget _buildSubscriptionItem({
    required IconData icon,
    required String category,
    required double amount,
    required double progress,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color),
              const SizedBox(width: 8),
              Text(
                category,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              const Spacer(),
              Text(
                '₹${amount.toStringAsFixed(2)}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.white10,
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ],
      ),
    );
  }
}