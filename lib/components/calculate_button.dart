import 'package:flutter/material.dart';
import 'package:imc_calculator/core/app_colors.dart';

class CalculateButton extends StatelessWidget {
  final String buttonText;
  final Function onPressed;

  const CalculateButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Botón "CALCULAR"
        SizedBox(
          height: 60,
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => onPressed(),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary, // Color de fondo del botón
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8), // Borde redondeado
              ),
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 100),
            ),
            child: Text(
              buttonText,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
