import 'package:flutter/material.dart';
import 'package:pocket_pal/pages/spin_wheel_screen.dart';

class DailyChallengeButton extends StatelessWidget {
  const DailyChallengeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurpleAccent,
        foregroundColor: Colors.white,
        textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 8,
      ),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const SpinWheelScreen()),
        );
      },
      child: const Text("Spin the Wheel! 🎰"),
    );
  }
}
