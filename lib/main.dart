import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:pocket_pal/pages/splash_screen.dart';
import 'package:pocket_pal/util/streak_provider.dart';
import 'package:pocket_pal/providers/expense_provider.dart';
import 'package:pocket_pal/providers/subscription_provider.dart'; // Import SubscriptionProvider


void main() {
  // Ensure bindings are initialized before using plugins or SystemChrome
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => StreakCoinProvider()
          ..loadData()
          ..updateStreakWithDate()),
        ChangeNotifierProvider(create: (_) => ExpenseProvider()),
        ChangeNotifierProvider(create: (_) => SubscriptionProvider()), // Add this provider
      ],
      child: const MyApp(),
    ),
  );
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
