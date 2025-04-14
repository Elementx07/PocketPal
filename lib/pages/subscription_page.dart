import 'package:flutter/material.dart';
import 'package:pocket_pal/widgets/horizontal_cards.dart';
import 'package:rive/rive.dart'; 
import 'package:pocket_pal/widgets/add_subscription_dialog.dart';

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
                    child: ListView(
                      children: [
                        const Text(
                          'Breakdown of your subscription costs',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildSubscriptionItem(
                          icon: Icons.movie,
                          category: 'Entertainment',
                          amount: 848,
                          progress: 0.8,
                          color: Colors.purple,
                        ),
                        _buildSubscriptionItem(
                          icon: Icons.music_note,
                          category: 'Music',
                          amount: 199,
                          progress: 0.3,
                          color: Colors.red,
                        ),
                        _buildSubscriptionItem(
                          icon: Icons.work,
                          category: 'Productivity',
                          amount: 125,
                          progress: 0.2,
                          color: Colors.orange,
                        ),
                        _buildSubscriptionItem(
                          icon: Icons.shopping_bag,
                          category: 'Shopping',
                          amount: 999,
                          progress: 0.95,
                          color: Colors.green,
                        ),
                      ],

                      
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
          // add subscription dialog widget
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


  Widget _buildSubscriptionItem({
    required IconData icon,
    required String category,
    required double amount,
    required double progress,
    required Color color,
  }) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              Icon(icon, color: color),
              const SizedBox(width: 8),
              Text(
                category,
                style: const TextStyle(color: Colors.white70),
              ),
              const Spacer(),
              Text(
                '₹$amount/month',
                style: const TextStyle(color: Colors.white70),
              ),
            ],
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey[800],
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 8,
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

}
