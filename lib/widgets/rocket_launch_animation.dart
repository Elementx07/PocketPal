import 'package:flutter/material.dart';

import 'dart:async';
import 'package:lottie/lottie.dart';
import 'cosmos.dart';


class RocketLaunchAnimation extends StatefulWidget {
  final VoidCallback onAnimationComplete;


  const RocketLaunchAnimation({Key? key, required this.onAnimationComplete})
      : super(key: key);

  @override
  _RocketLaunchAnimation createState() => _RocketLaunchAnimation();
}

class _RocketLaunchAnimation extends State<RocketLaunchAnimation>

    with TickerProviderStateMixin {
  late AnimationController _initialLaunchController;
  late AnimationController _midPauseController;
  late AnimationController _finalLaunchController;

  late Animation<Offset> _initialOffset;
  late Animation<Offset> _midOffset;
  late Animation<Offset> _finalOffset;


  String countdownText = '';
  bool animationReady = false;

  late Timer _countdownTimer;


  @override
  void initState() {
    super.initState();

    _initialLaunchController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _midPauseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _finalLaunchController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _initialOffset = Tween<Offset>(
      begin: const Offset(0, 2),
      end: const Offset(0, 0.4),
    ).animate(
      CurvedAnimation(
        parent: _initialLaunchController,
        curve: Curves.easeOutBack,
      ),
    );

    _midOffset = Tween<Offset>(
      begin: const Offset(0, 0.4),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(parent: _midPauseController, curve: Curves.easeOutBack),
    );

    _finalOffset = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(0, -2),
    ).animate(
      CurvedAnimation(parent: _finalLaunchController, curve: Curves.easeInExpo),
    );

    animationReady = true; // Safe to build after this point
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startRocketSequence();
    });
  }

  Future<void> _startRocketSequence() async {
    await Future.delayed(const Duration(milliseconds: 400));
    await _initialLaunchController.forward();

    await Future.delayed(const Duration(milliseconds: 250));
    await _midPauseController.forward();

    setState(() {
      countdownText = '3';
    });

    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdownText == '3') {
        setState(() {
          countdownText = '2';
        });
      } else if (countdownText == '2') {
        setState(() {
          countdownText = '1';
        });
      } else if (countdownText == '1') {
        setState(() {
          countdownText = ''; // Clear the countdown text
        });

        // Stop the timer after the countdown is done
        _countdownTimer.cancel();
      }
    });

    await Future.delayed(
        const Duration(seconds: 3)); // Wait for countdown to finish

    await _finalLaunchController.forward();

    widget.onAnimationComplete(); // Notify that animation is complete
  }

  @override
  void dispose() {

    _initialLaunchController.dispose();
    _midPauseController.dispose();
    _finalLaunchController.dispose();
    _countdownTimer.cancel(); // Cancel the timer on dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!animationReady) {
      return const SizedBox(); // Return empty if not ready

    }

    return Stack(
      children: [
        const CosmosBackground(),
        AnimatedBuilder(
          animation: Listenable.merge([
            _initialLaunchController,
            _midPauseController,
            _finalLaunchController,
          ]),
          builder: (context, child) {
            Offset currentOffset = _initialOffset.value;

            if (_midPauseController.isAnimating ||
                _midPauseController.isCompleted) {
              currentOffset = _midOffset.value;
            }
            if (_finalLaunchController.isAnimating ||
                _finalLaunchController.isCompleted) {
              currentOffset = _finalOffset.value;
            }

            return FractionalTranslation(
              translation: currentOffset,
              child: child,
            );
          },
          child: Center(
            child: SizedBox(
              width: 300,
              height: 300,
              child: Lottie.asset('assets/animations/rocketttt.json'),
            ),
          ),
        ),
        if (countdownText.isNotEmpty) // Only show countdown when it's not empty
          Positioned(
            bottom:
                330, // Adjust this value to position the text below the rocket
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'Launching Game Mode in $countdownText',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Arcade',
                ),
              ),
            ),
          ),
      ],
    );
  }
}
