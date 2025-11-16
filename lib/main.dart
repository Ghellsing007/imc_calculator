import 'package:flutter/material.dart';
import 'package:imc_calculator/core/app_colors.dart';
import 'package:imc_calculator/screens/imc_home_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("IMC CALCULATOR"),
          backgroundColor: AppColors.backgrounds,
          foregroundColor: AppColors.white,
        ),
        backgroundColor: AppColors.backgrounds,
        body: ImcHomeScreen(),
      ),
    );
  }
}
