class Subscription {
  final String id;
  final String serviceName;
  final String plan;
  final double price;
  final String billingCycle;
  final String category;
  final DateTime startDate;
  final String paymentMethod;
  final String paymentDetails;

  Subscription({
    required this.id,
    required this.serviceName,
    required this.plan,
    required this.price,
    required this.billingCycle,
    required this.category,
    required this.startDate,
    required this.paymentMethod,
    required this.paymentDetails,
  });
}