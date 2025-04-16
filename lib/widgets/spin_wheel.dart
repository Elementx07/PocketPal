import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:confetti/confetti.dart';
import 'package:pocket_pal/widgets/game_mode_text.dart'; // Make sure this provides `arcadeFont`

class WheelPrize {
  final String name;
  final String? imagePath;

  WheelPrize({required this.name, this.imagePath});
}

class Wheel extends StatefulWidget {
  const Wheel({super.key});

  @override
  State<Wheel> createState() => _WheelState();
}

class _WheelState extends State<Wheel> {
  StreamController<int> controller = StreamController<int>();
  int? outcome;
  late ConfettiController _confettiController;

  final List<WheelPrize> prizes = [
    WheelPrize(name: "Rocket Boost", imagePath: "assets/123.jpg"),
    WheelPrize(name: "50 Coins", imagePath: "assets/coins.jpg"),
    WheelPrize(name: "Streak Freeze", imagePath: "assets/streak_freeze.webp"),
    WheelPrize(name: "Daily XP", imagePath: "assets/logo.jpg"),
    WheelPrize(name: "Mystery Box", imagePath: "assets/box.jpg"),
    WheelPrize(name: "Lucky Charm", imagePath: "assets/clover.png"),
  ];

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 2));
  }

  @override
  void dispose() {
    controller.close();
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 🛞 The Fortune Wheel centered
        Align(
          alignment: Alignment.center,
          child: Material(
            color: Colors.transparent,
            shape: const CircleBorder(),
            elevation: 6,
            child: FortuneWheel(
              selected: controller.stream,
              animateFirst: false,
              hapticImpact: HapticImpact.medium,
              indicators: const [
                FortuneIndicator(
                  alignment: Alignment.topCenter,
                  child: TriangleIndicator(
                    color: Colors.white,
                    width: 30.0,
                    height: 40.0,
                    elevation: 10,
                  ),
                ),
              ],
              items: prizes.map((prize) {
                return FortuneItem(
                  child: RotatedBox(
                    quarterTurns: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 50),
                      child: prize.imagePath != null
                          ? Image.asset(prize.imagePath!, width: 50)
                          : Text(
                              prize.name,
                              style: arcadeFont(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                    ),
                  ),
                  style: FortuneItemStyle(
                    color: Colors.primaries[
                            prizes.indexOf(prize) % Colors.primaries.length]
                        .withOpacity(0.6),
                    borderWidth: 0,
                  ),
                );
              }).toList(),
              onFling: () {
                setState(() {
                  outcome = Random().nextInt(prizes.length);
                  controller.add(outcome!);
                });
              },
              onAnimationEnd: () {
                if (outcome == null) return;

                final prize = prizes[outcome!];
                _confettiController.play();

                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    backgroundColor: Colors.black87,
                    title: Center(
                      child: Text(
                        "🎉 You Won!",
                        style: arcadeFont(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (prize.imagePath != null)
                          Image.asset(prize.imagePath!, width: 80),
                        const SizedBox(height: 10),
                        Text(
                          prize.name,
                          style: arcadeFont(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    actionsAlignment: MainAxisAlignment.center,
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // close dialog
                          Navigator.of(context).pop(); // go back
                        },
                        child: Text(
                          "Back to Game Mode",
                          style: arcadeFont(
                            fontSize: 16,
                            color: Colors.purpleAccent,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),

        // 🎉 Confetti blast layer - ABOVE everything
        Positioned.fill(
          child: IgnorePointer(
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: ConfettiWidget(
                    confettiController: _confettiController,
                    blastDirection: 0,
                    emissionFrequency: 0.1,
                    numberOfParticles: 20,
                    maxBlastForce: 15,
                    minBlastForce: 8,
                    gravity: 0.4,
                    shouldLoop: false,
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: ConfettiWidget(
                    confettiController: _confettiController,
                    blastDirection: pi,
                    emissionFrequency: 0.1,
                    numberOfParticles: 20,
                    maxBlastForce: 15,
                    minBlastForce: 8,
                    gravity: 0.4,
                    shouldLoop: false,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
