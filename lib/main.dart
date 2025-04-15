import 'package:flutter/material.dart';
import 'package:pocket_pal/pages/dash.dart';
import 'package:pocket_pal/pages/sign_in.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:pocket_pal/providers/expense_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ExpenseProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    return MaterialApp(debugShowCheckedModeBanner: false, home: DashBoardPage());
  }
}
