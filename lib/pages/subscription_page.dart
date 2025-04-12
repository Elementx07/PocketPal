import 'package:flutter/material.dart';
import 'package:pocket_pal/widgets/horizontal_cards.dart';
import 'package:rive/rive.dart'; // Add this import

class SubscriptionPage extends StatelessWidget {
  const SubscriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Subscription    Tracker', 
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              fontFamily: 'Arcade',
              color: Colors.white,
            )),
        backgroundColor: const Color.fromARGB(255, 49, 2, 65),
        //remove back button
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          const Positioned.fill(
            child: RiveAnimation.asset(
              'assets/animations/cosmos.riv',
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Search Bar
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: const TextStyle(color: Colors.white70),
                    prefixIcon: const Icon(Icons.search, color: Colors.white70),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.purple.shade100),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.purple),
                    ),
                    fillColor: const Color.fromARGB(70, 168, 140, 215),
                    filled: true,
                  ),
                ),
                const SizedBox(height: 20),

                // Active/Expired Cards
                const HorizontalCards(isSubscriptionPage: true),
                const SizedBox(height: 20),

                // Spending Insights
                const Text(
                  'Spending Insights',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,
                      color: Colors.white),
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
                    child: const Center(
                      child: Text('Display list of subscriptions here',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                          )),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Implement add subscription functionality
        },
        backgroundColor: const Color.fromARGB(255, 49, 2, 65),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
