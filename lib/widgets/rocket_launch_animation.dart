import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class RocketLaunchAnimation extends StatefulWidget {
  final VoidCallback onAnimationComplete;

  const RocketLaunchAnimation({super.key, required this.onAnimationComplete});

  @override
  State<RocketLaunchAnimation> createState() => _RocketLaunchAnimationState();
}

class _RocketLaunchAnimationState extends State<RocketLaunchAnimation>
    with TickerProviderStateMixin {
  late AnimationController _initialLaunchController;
  late AnimationController _midPauseController;
  late AnimationController _finalLaunchController;

  late Animation<Offset> _initialOffset;
  late Animation<Offset> _midOffset;
  late Animation<Offset> _finalOffset;

  bool showCountdownText = false;
  bool animationReady = false; // 👈 NEW FLAG to avoid early build
  bool _isDisposed = false; // Add this flag at the class level

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

    animationReady = true; // 👈 Now it's safe to build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startRocketSequence();
    });
  }

  Future<void> _startRocketSequence() async {
    if (_isDisposed) return; // Early return if disposed
    
    await Future.delayed(const Duration(milliseconds: 500));
    if (_isDisposed) return;
    await _initialLaunchController.forward();

    await Future.delayed(const Duration(milliseconds: 300));
    if (_isDisposed) return;
    await _midPauseController.forward();

    if (_isDisposed) return;
    setState(() {
      showCountdownText = true;
    });

    await Future.delayed(const Duration(seconds: 3));
    if (_isDisposed) return;
    await _finalLaunchController.forward();

    if (_isDisposed) return;
    widget.onAnimationComplete();
  }

  @override
  void dispose() {
    _isDisposed = true; // Set flag before disposing controllers
    _initialLaunchController.dispose();
    _midPauseController.dispose();
    _finalLaunchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!animationReady) {
      return const SizedBox(); // return empty if not ready
    }

    return Stack(
      children: [
        Container(color: Colors.black),

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
              width: 250,
              height: 250,
              child: Lottie.asset('assets/animations/rocketttt.json'),
            ),
          ),
        ),

        if (showCountdownText)
          const Center(
            child: Text(
              'Launching Game Mode in 3...2...1',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    );
  }
}
