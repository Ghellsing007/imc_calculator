import 'package:flutter/material.dart';
import 'package:imc_calculator/core/app_colors.dart';

class CalculateButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final double density;

  const CalculateButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    this.density = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    final double scale = density.clamp(0.6, 1.0);
    final double minHeight = (56 * scale).clamp(44.0, 56.0);
    final double horizontalPadding = (24 * scale).clamp(16.0, 24.0);
    final double radius = (12 * scale).clamp(10.0, 12.0);
    final double fontSize = (16 * scale).clamp(13.0, 16.0);

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          minimumSize: Size.fromHeight(minHeight),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        ),
        child: Text(
          buttonText,
          style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
