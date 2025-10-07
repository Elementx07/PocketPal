import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pocket_pal/providers/subscription_provider.dart';
import 'package:pocket_pal/models/subscription.dart';
import 'package:uuid/uuid.dart';
class AddSubscriptionDialog extends StatefulWidget {
  const AddSubscriptionDialog({super.key});

  @override
  State<AddSubscriptionDialog> createState() => _AddSubscriptionDialogState();
}

class _AddSubscriptionDialogState extends State<AddSubscriptionDialog> {
  final _formKey = GlobalKey<FormState>();
  final _serviceNameController = TextEditingController();
  final _planController = TextEditingController();
  final _priceController = TextEditingController();
  final _paymentDetailsController = TextEditingController();
  String _billingCycle = 'Monthly';
  String _category = 'Entertainment';
  String _paymentMethod = 'Credit Card';

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final subscription = Subscription(
        id: const Uuid().v4(),
        serviceName: _serviceNameController.text,
        plan: _planController.text,
        price: double.parse(_priceController.text),
        billingCycle: _billingCycle,
        category: _category,
        startDate: DateTime.now(),
        paymentMethod: _paymentMethod,
        paymentDetails: _paymentDetailsController.text,
      );

      Provider.of<SubscriptionProvider>(context, listen: false)
          .addSubscription(subscription);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(color: Colors.white);
    const labelStyle = TextStyle(color: Colors.white, fontSize: 16);
    const inputDecoration = InputDecoration(
      hintStyle: TextStyle(color: Colors.white70),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
    );

    return Dialog(
      backgroundColor: const Color.fromARGB(255, 66, 65, 65),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 350, maxHeight: 600),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Add New Subscription',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text('Service Name', style: labelStyle),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _serviceNameController,
                          style: textStyle,
                          decoration: inputDecoration.copyWith(
                            hintText: 'Netflix, Spotify, etc.',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a service name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        const Text('Plan', style: labelStyle),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _planController,
                          style: textStyle,
                          decoration: inputDecoration.copyWith(
                            hintText: 'Premium, Basic, etc.',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a plan';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        const Text('Price', style: labelStyle),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _priceController,
                          style: textStyle,
                          decoration: inputDecoration.copyWith(
                            hintText: '9.99',
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a price';
                            }
                            if (double.tryParse(value) == null) {
                              return 'Please enter a valid number';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        const Text('Billing Cycle', style: labelStyle),
                        const SizedBox(height: 8),
                        DropdownButtonFormField<String>(
                          style: textStyle,
                          dropdownColor: const Color.fromARGB(255, 66, 65, 65),
                          decoration: inputDecoration,
                          initialValue: _billingCycle,
                          items: ['Monthly', 'Yearly', 'Quarterly']
                              .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e, style: textStyle),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _billingCycle = value!;
                            });
                          },
                        ),
                        const SizedBox(height: 16),
                        const Text('Category', style: labelStyle),
                        const SizedBox(height: 8),
                        DropdownButtonFormField<String>(
                          style: textStyle,
                          dropdownColor: const Color.fromARGB(255, 66, 65, 65),
                          decoration: inputDecoration,
                          initialValue: _category,
                          items: ['Entertainment', 'Music', 'Streaming', 'Other']
                              .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e, style: textStyle),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _category = value!;
                            });
                          },
                        ),
                        const SizedBox(height: 16),
                        const Text('Start Date', style: labelStyle),
                        const SizedBox(height: 8),
                        TextFormField(
                          style: textStyle,
                          decoration: inputDecoration.copyWith(
                            hintText: 'mm/dd/yyyy',
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text('Payment Method', style: labelStyle),
                        const SizedBox(height: 8),
                        DropdownButtonFormField<String>(
                          style: textStyle,
                          dropdownColor: const Color.fromARGB(255, 66, 65, 65),
                          decoration: inputDecoration,
                          initialValue: _paymentMethod,
                          items: ['Credit Card', 'UPI', 'Bank Transfer']
                              .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e, style: textStyle),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _paymentMethod = value!;
                            });
                          },
                        ),
                        const SizedBox(height: 16),
                        const Text('Card Number or UPI Number', style: labelStyle),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _paymentDetailsController,
                          style: textStyle,
                          decoration: inputDecoration.copyWith(
                            hintText: 'Last 4 digits',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter payment details';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel',
                        style: TextStyle(color: Colors.white)),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Add Subscription'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}