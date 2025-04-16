import 'package:flutter/material.dart';
import 'package:pocket_pal/widgets/cosmos.dart';
import 'package:pocket_pal/widgets/spin_wheel.dart';

class SpinWheelScreen extends StatelessWidget {
  const SpinWheelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 🌌 Space background
          Positioned.fill(child: const CosmosBackground()),

// 🎯 Title and wheel
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "🎯 Spin to Win!",
                  style: TextStyle(
                    fontSize: 28,
                    fontFamily: 'Arcade',
                    color: Colors.white,
                    wordSpacing: 3,
                  ),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  height: 400,
                  child: const Wheel(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
