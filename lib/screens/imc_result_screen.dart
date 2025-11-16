import 'package:flutter/material.dart';
import 'package:imc_calculator/core/app_colors.dart';
import 'package:imc_calculator/core/text_stytles.dart';

class ImcResultScreen extends StatelessWidget {
  final String genero;
  final int peso;
  final int edad;
  final int altura;

  const ImcResultScreen({
    super.key,
    required this.genero,
    required this.peso,
    required this.edad,
    required this.altura,
  });

  // ⭐ Calcular IMC
  double calcularIMC() {
    double alturaEnMetros = altura / 100;
    return peso / (alturaEnMetros * alturaEnMetros);
  }

  // ⭐ Clasificación
  String clasificacionIMC(double imc) {
    if (imc < 18.5) return "BAJO PESO";
    if (imc < 25) return "NORMAL";
    if (imc < 30) return "SOBREPESO";
    return "OBESIDAD";
  }

  // ⭐ Color según IMC
  Color getColorByImc(double imc) {
    return switch (imc) {
      < 18.5 => Colors.blue,
      < 25 => Colors.green,
      < 30 => Colors.orange,
      _ => Colors.red,
    };
  }

  // ⭐ Descripción + Recomendaciones
  String recomendaciones(double imc) {
    if (imc < 18.5) {
      return "Tu IMC indica bajo peso. "
          "Recomendaciones:\n"
          "• Aumenta tu consumo calórico con alimentos nutritivos.\n"
          "• Realiza ejercicios de fuerza para ganar masa muscular.\n"
          "• Come cada 3–4 horas.\n"
          "• Considera una evaluación nutricional.";
    } else if (imc < 25) {
      return "Tienes un peso saludable. "
          "Recomendaciones:\n"
          "• Mantén una dieta equilibrada.\n"
          "• Realiza actividad física 3–5 veces por semana.\n"
          "• Hidrátate bien.\n"
          "• Duerme de 7 a 9 horas.";
    } else if (imc < 30) {
      return "Tu IMC indica sobrepeso. "
          "Recomendaciones:\n"
          "• Reduce azúcares y harinas refinadas.\n"
          "• Aumenta consumo de vegetales y proteínas.\n"
          "• Haz ejercicios cardiovasculares y de fuerza.\n"
          "• Mantén un déficit calórico moderado.";
    } else {
      return "Tu IMC indica obesidad. "
          "Recomendaciones:\n"
          "• Inicia un plan alimenticio con control de calorías.\n"
          "• Aumenta tu actividad física progresivamente.\n"
          "• Evita bebidas azucaradas y comidas procesadas.\n"
          "• Considera asesoría profesional.\n"
          "• Lleva seguimiento semanal.";
    }
  }

  @override
  Widget build(BuildContext context) {
    final double imc = calcularIMC();
    final String categoria = clasificacionIMC(imc);
    final Color categoriaColor = getColorByImc(imc);
    final String descripcion = recomendaciones(imc);

    return Scaffold(
      appBar: AppBar(
        title: Text("Resultado"),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      backgroundColor: AppColors.backgrounds,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Tu resultado",
              style: TextStyle(
                fontSize: 34,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 20),

            // ⭐ CARD CENTRAL
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.backgroundsComponent,
                  borderRadius: BorderRadius.circular(16),
                ),
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),

                child: Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    // Estado
    Text(
      categoria,
      style: TextStyle(
        color: categoriaColor,
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
    ),
    SizedBox(height: 20),

    // IMC
    Text(
      imc.toStringAsFixed(2),
      style: TextStyle(
        fontSize: 60,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    SizedBox(height: 20),

    // 🟩 Contenedor interno organizado
    Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        descripcion,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16,
          color: Colors.white70,
          height: 1.4,
        ),
      ),
    ),
  ],
),

              ),
            ),

            SizedBox(height: 20),

            // BOTÓN FINALIZAR
            SizedBox(
              height: 60,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  "Finalizar",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
