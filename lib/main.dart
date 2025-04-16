import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:pocket_pal/pages/splash_screen.dart';

import 'package:pocket_pal/util/streak_provider.dart';
import 'package:pocket_pal/providers/expense_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => StreakCoinProvider()
              ..loadData()
              ..updateStreakWithDate()),
        ChangeNotifierProvider(create: (_) => ExpenseProvider()),
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
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
