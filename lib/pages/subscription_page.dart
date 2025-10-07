import 'package:flutter/material.dart';
import 'package:pocket_pal/widgets/add_subscription_dialog.dart';
import 'package:pocket_pal/widgets/subscription_list_view.dart';

class SubscriptionPage extends StatelessWidget {
  const SubscriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Subscription Tracker',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              fontFamily: 'Arcade',
              color: Colors.white,
            )),
        backgroundColor: const Color.fromARGB(255, 49, 2, 65),
        automaticallyImplyLeading: false,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SubscriptionListView(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const AddSubscriptionDialog(),
          );
        },
        backgroundColor: const Color.fromARGB(255, 49, 2, 65),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
