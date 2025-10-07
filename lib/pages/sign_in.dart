import 'package:flutter/material.dart';
import 'package:pocket_pal/pages/dash.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _errorText = '';
  bool _acceptedTerms = false;

  final String _termsText = '''
Terms and Conditions for Pocket Pal

1. Acceptance of Terms
By accessing and using Pocket Pal, you agree to be bound by these Terms and Conditions.

2. User Responsibilities
- You are responsible for maintaining the confidentiality of your account
- You agree not to share your account credentials with third parties
- You must be at least 13 years old to use this application

3. Privacy Policy
We collect and process your data in accordance with our Privacy Policy. By using Pocket Pal, you consent to such processing.

4. Limitations of Liability
Pocket Pal is provided "as is" without any warranties, expressed or implied.

5. Changes to Terms
We reserve the right to modify these terms at any time. Continued use of the application constitutes acceptance of modified terms.

6. Termination
We reserve the right to terminate or suspend access to our application without prior notice.
''';

  late AnimationController _animationController;
  late Animation<double> _fadeAnimationLogo;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _fadeAnimationLogo = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _validateAndSignIn() {
    if (_usernameController.text == 'pocketpal' &&
        _passwordController.text == '1234') {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 1500),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          pageBuilder: (_, __, ___) => const DashBoardPage(),
        ),
      );
    } else {
      setState(() {
        _errorText = 'Incorrect username or password.';
      });
    }
  }
  void _showTermsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Terms and Conditions',
            style: TextStyle(fontFamily: 'Arcade'),
          ),
          content: SingleChildScrollView(
            child: Text(
              _termsText,
              style: const TextStyle(fontSize: 14),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Close',
                style: TextStyle(fontFamily: 'Arcade'),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildAnimatedTextField(TextEditingController controller, String hint,
      {bool obscureText = false}) {
    return FadeTransition(
      opacity: _fadeAnimationLogo,
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white54),
          filled: true,
          fillColor: const Color.fromARGB(100, 255, 255, 255),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildButton() {
    return Column(
      children: [
        Row(
          children: [
            Checkbox(
              value: _acceptedTerms,
              onChanged: (bool? value) {
                setState(() {
                  _acceptedTerms = value ?? false;
                });
              },
              fillColor: WidgetStateProperty.resolveWith(
                (states) => Colors.deepPurpleAccent,
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () => _showTermsDialog(),
                child: const Text(
                  'I accept the Terms & Conditions',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Arcade',
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        GestureDetector(
          onTap: _acceptedTerms ? _validateAndSignIn : null,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
            decoration: BoxDecoration(
              color: _acceptedTerms 
                  ? Colors.deepPurpleAccent 
                  : Colors.grey,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: const Text(
              'Sign In',
              style: TextStyle(
                fontFamily: 'Arcade',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 71, 0, 133),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 130),
                  SizedBox(
                    height: 220, // Adjust this value based on your needs
                    width: double.infinity,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          top: 0,
                          child: AnimatedBuilder(
                            animation: _animationController,
                            builder: (context, child) {
                              return Opacity(
                                opacity: _fadeAnimationLogo.value,
                                child: Transform.scale(
                                  scale: _scaleAnimation.value,
                                  child: Image.asset('assets/normal_state.png', height: 150),
                                ),
                              );
                            },
                          ),
                        ),
                        Positioned(
                          bottom: 17,
                          child: AnimatedBuilder(
                            animation: _animationController,
                            builder: (context, child) {
                              return Opacity(
                                opacity: _fadeAnimationLogo.value,
                                child: Text(
                                  'Pocket Pal',
                                  style: TextStyle(
                                    fontSize: 60,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Arcade',
                                    color: Colors.white,
                                    shadows: [
                                      Shadow(
                                        color: Colors.purple.withOpacity(0.6),
                                        blurRadius: 15.0,
                                        offset: const Offset(0, 0),
                                      ),
                                      Shadow(
                                        color: Colors.blueAccent.withOpacity(0.6),
                                        blurRadius: 15.0,
                                        offset: const Offset(0, 0),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  _buildAnimatedTextField(_usernameController, 'Username'),
                  const SizedBox(height: 20),
                  _buildAnimatedTextField(_passwordController, 'Password',
                      obscureText: true),
                  if (_errorText.isNotEmpty)
                    Text(
                      _errorText,
                      style: const TextStyle(color: Colors.redAccent),
                    ),
                  const SizedBox(height: 30),
                  _buildButton(),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontFamily: 'Arcade',
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
