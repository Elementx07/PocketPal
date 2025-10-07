import 'package:flutter/material.dart';
import 'package:pocket_pal/pages/sign_in.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String _displayText = '';
  final String _fullText = 'Welcome,   User';
  int _currentIndex = 0;
  bool _isAnimationComplete = false;
  bool _isNavigating = false;

  @override
  void initState() {
    super.initState();
    _startTypewriterAnimation();
  }

  void _startTypewriterAnimation() {
    Future.delayed(const Duration(milliseconds: 150), () {
      if (_currentIndex < _fullText.length) {
        setState(() {
          _displayText = _fullText.substring(0, _currentIndex + 1);
          _currentIndex++;
        });
        _startTypewriterAnimation(); // Recursive call for the next character
      } else {
        // Animation is complete
        setState(() {
          _isAnimationComplete = true;
        });
      }
    });
  }

  void _navigateToSignIn() {
    // Only navigate if animation is complete and not already navigating
    if (!_isAnimationComplete || _isNavigating) return;
    
    setState(() {
      _isNavigating = true;
    });
    
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 1000),
        pageBuilder: (_, __, ___) => const SignInScreen(),
        transitionsBuilder: (_, animation, __, child) =>
            FadeTransition(opacity: animation, child: child),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    const skyBlueColor = Color.fromARGB(255, 177, 229, 228);

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            color: skyBlueColor,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: screenHeight * 0.4,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    //in hex
                    Color(0xFFFFEB3B), // Yellow
                    Color(0xFFF4B433), // Amber
                  ],
                  begin: Alignment.bottomRight,
                  end: Alignment.bottomLeft,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: _navigateToSignIn,
            child: Container(
              color: Colors.transparent,
              child: Center(
                child: Column( // Use a Column to stack the image and text
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/logo.jpg',
                      height: screenHeight * 0.6,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 20), // Add some spacing between the image and text
                    Text(
                      _displayText,
                      style: const TextStyle(
                        fontSize: 50.0,
                        fontFamily: 'Arcade',
                        color: Color.fromARGB(255, 111, 60, 214),
                        //shadow:
                        shadows: [
                          Shadow(
                            color: Color.fromARGB(255, 242, 239, 239),
                            offset: Offset(2.0, 2.0),
                            blurRadius: 3.0,
                          ),
                        ],
                      ),
                    ),
                    if (_isAnimationComplete) ...[
                      const SizedBox(height: 20),
                      const Text(
                        'tap   anywhere',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'Arcade',
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
