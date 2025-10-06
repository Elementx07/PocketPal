import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pocket_pal/pages/splash_screen.dart';

void main() {
  // Ensure bindings are initialized before using plugins or SystemChrome
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(), // Use the SplashScreen as the initial screen
    );
  }
}