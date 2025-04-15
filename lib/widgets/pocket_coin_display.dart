import 'package:flutter/material.dart';

class PocketCoinsWidget extends StatelessWidget {
  final int coins;

  const PocketCoinsWidget({super.key, required this.coins});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.deepPurple,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(Icons.monetization_on, color: Colors.yellowAccent, size: 20),
          const SizedBox(width: 4),
          Text(
            '$coins',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}
