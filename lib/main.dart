import 'package:flutter/material.dart';
import 'package:localmart/localmart.dart/onboarding.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LocalMart',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0025A5),
          primary: const Color(0xFF0025A5),
        ),
        useMaterial3: true,
      ),
      home: const OnboardingPage(),
    );
  }
}
