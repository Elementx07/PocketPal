import 'package:flutter/material.dart';
import 'package:pocket_pal/pages/sign_in.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);

    return MaterialApp(debugShowCheckedModeBanner: false, home: SignInScreen());
  }
}
