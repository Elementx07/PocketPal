import 'package:flutter/material.dart';
import '../models/subscription.dart';

class SubscriptionProvider extends ChangeNotifier {
  final List<Subscription> _subscriptions = [
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
    Subscription(
      id: '4',
      serviceName: 'Gold\'s Gym',
      plan: 'Premium Membership',
      price: 49.99,
      billingCycle: 'Monthly',
      category: 'Fitness',
      startDate: DateTime.now(),
      paymentMethod: 'Bank Transfer',
      paymentDetails: '6103',
    ),
    Subscription(
      id: '5',
      serviceName: 'YouTube Premium',
      plan: 'Individual',
      price: 11.99,
      billingCycle: 'Monthly',
      category: 'Entertainment',
      startDate: DateTime.now(),
      paymentMethod: 'Credit Card',
      paymentDetails: '3750',
    ),
  ];

  List<Subscription> get subscriptions => List.unmodifiable(_subscriptions);

  double get totalMonthlyExpense {
    return _subscriptions.fold(0, (sum, subscription) {
      if (subscription.billingCycle == 'Yearly') {
        return sum + (subscription.price / 12);
      }
      return sum + subscription.price;
    });
  }

  void addSubscription(Subscription subscription) {
    _subscriptions.add(subscription);
    notifyListeners();
  }

  void removeSubscription(String id) {
    _subscriptions.removeWhere((subscription) => subscription.id == id);
    notifyListeners();
  }
}