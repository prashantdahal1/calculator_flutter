import 'package:flutter/material.dart';
import 'screens/calculator_screen.dart';

class Calculator extends StatelessWidget {
  const Calculator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator App',
      home: const CalculatorScreen(),
    );
  }
}
