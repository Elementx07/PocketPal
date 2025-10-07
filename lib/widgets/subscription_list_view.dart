import 'package:flutter/material.dart';
import '../models/subscription.dart';
import 'subscription_insights.dart';

class SubscriptionListView extends StatelessWidget {
  const SubscriptionListView({super.key});

  // Static subscription data
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

    return Column(
      children: [
        // Tab buttons for Active/Upcoming/Expired
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildFilterButton('Active', true),
              _buildFilterButton('Upcoming', false),
              _buildFilterButton('Expired', false),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Subscription List
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(15),
            ),
            child: subscriptions.isEmpty
                ? const Center(
                    child: Text(
                      'No subscriptions yet',
                      style: TextStyle(color: Colors.white70),
                    ),
                  )
                : ListView.builder(
                    itemCount: subscriptions.length,
                    itemBuilder: (context, index) {
                      final subscription = subscriptions[index];
                      return _buildSubscriptionCard(
                        context: context,
                        icon: subscription.serviceName[0],
                        iconColor: _getIconColor(subscription.category),
                        serviceName: subscription.serviceName,
                        amount: '₹${subscription.price}/${_getBillingShortForm(subscription.billingCycle)}',
                        plan: subscription.plan,
                        billing: subscription.billingCycle,
                        nextPayment: _formatDate(subscription.startDate),
                        paymentMethod: '${subscription.paymentMethod}(${subscription.paymentDetails})',
                        subscriptionId: subscription.id,
                      );
                    },
                  ),
          ),
        ),

        // Insights Button
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: ElevatedButton.icon(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) => const SubscriptionInsights(),
              );
            },
            icon: const Icon(Icons.insights, color: Colors.white),
            label: const Text('View Insights',
                style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 49, 2, 65),
              padding: const EdgeInsets.symmetric(
                  horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Color _getIconColor(String category) {
    switch (category.toLowerCase()) {
      case 'entertainment':
        return Colors.red;
      case 'music':
        return Colors.green;
      case 'streaming':
        return Colors.blue;
      default:
        return Colors.purple;
    }
  }

  String _getBillingShortForm(String billingCycle) {
    switch (billingCycle.toLowerCase()) {
      case 'monthly':
        return 'mo';
      case 'yearly':
        return 'yr';
      case 'quarterly':
        return 'qtr';
      default:
        return '';
    }
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  Widget _buildFilterButton(String text, bool isSelected) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color.fromARGB(255, 49, 2, 65)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.white70,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildSubscriptionCard({
    required BuildContext context,
    required String icon,
    required Color iconColor,
    required String serviceName,
    required String amount,
    required String plan,
    required String billing,
    required String nextPayment,
    required String paymentMethod,
    required String subscriptionId,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.white.withOpacity(0.05),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: iconColor,
                  child: Text(icon, style: const TextStyle(color: Colors.white)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        serviceName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        amount,
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    plan,
                    style: const TextStyle(color: Colors.white70),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildInfoChip(billing),
                  const SizedBox(width: 8),
                  _buildInfoChip(nextPayment),
                  const SizedBox(width: 8),
                  _buildInfoChip(paymentMethod),
                  const SizedBox(width: 8),
                  TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          backgroundColor: const Color.fromARGB(255, 49, 2, 65),
                          title: const Text(
                            'Cancel Subscription?',
                            style: TextStyle(color: Colors.white),
                          ),
                          content: const Text(
                            'Are you sure you want to cancel this subscription?',
                            style: TextStyle(color: Colors.white70),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text(
                                'No',
                                style: TextStyle(color: Colors.white70),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                // Static implementation - just close dialog
                                Navigator.of(context).pop();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Subscription cancelled'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              },
                              child: const Text(
                                'Yes',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: Colors.blue),
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

  Widget _buildInfoChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white70),
      ),
    );
  }
}