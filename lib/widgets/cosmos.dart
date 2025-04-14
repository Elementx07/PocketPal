import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class CosmosBackground extends StatelessWidget {
  const CosmosBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return const Positioned.fill(
      child: RiveAnimation.asset(
        'assets/animations/cosmos.riv',
        fit: BoxFit.cover,
      ),
    );
  }
}