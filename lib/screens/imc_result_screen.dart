import 'package:flutter/material.dart';
import 'package:imc_calculator/components/calculate_button.dart';
import 'package:imc_calculator/core/app_colors.dart';

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

  double calcularIMC() {
    final double alturaEnMetros = altura / 100;
    return peso / (alturaEnMetros * alturaEnMetros);
  }

  String clasificacionIMC(double imc) {
    if (imc < 18.5) return "BAJO PESO";
    if (imc < 25) return "NORMAL";
    if (imc < 30) return "SOBREPESO";
    return "OBESIDAD";
  }

  Color getColorByImc(double imc) {
    return switch (imc) {
      < 18.5 => Colors.blue,
      < 25 => Colors.green,
      < 30 => Colors.orange,
      _ => Colors.red,
    };
  }

  String recomendaciones(double imc) {
    if (imc < 18.5) {
      return "Tu IMC indica bajo peso.\n"
          "Recomendaciones:\n"
          "- Aumenta tu consumo calorico con alimentos nutritivos.\n"
          "- Realiza ejercicios de fuerza para ganar masa muscular.\n"
          "- Come cada 3 a 4 horas.\n"
          "- Considera una evaluacion nutricional.";
    } else if (imc < 25) {
      return "Tienes un peso saludable.\n"
          "Recomendaciones:\n"
          "- Manten una dieta equilibrada.\n"
          "- Realiza actividad fisica 3 a 5 veces por semana.\n"
          "- Hidratate bien.\n"
          "- Duerme de 7 a 9 horas.";
    } else if (imc < 30) {
      return "Tu IMC indica sobrepeso.\n"
          "Recomendaciones:\n"
          "- Reduce azucares y harinas refinadas.\n"
          "- Aumenta consumo de vegetales y proteinas.\n"
          "- Haz ejercicios cardiovasculares y de fuerza.\n"
          "- Manten un deficit calorico moderado.";
    } else {
      return "Tu IMC indica obesidad.\n"
          "Recomendaciones:\n"
          "- Inicia un plan alimenticio controlando calorias.\n"
          "- Aumenta tu actividad fisica progresivamente.\n"
          "- Evita bebidas azucaradas y comidas procesadas.\n"
          "- Considera asesoria profesional y seguimiento.";
    }
  }

  @override
  Widget build(BuildContext context) {
    final double imc = calcularIMC();
    final String categoria = clasificacionIMC(imc);
    final Color categoriaColor = getColorByImc(imc);
    final String descripcion = recomendaciones(imc);

    return Scaffold(
      appBar: AppBar(title: const Text("Resultado")),
      backgroundColor: AppColors.backgrounds,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final bool isWide = constraints.maxWidth > 700;
            const double baseContentWidth = 520;
            final double density = (constraints.maxWidth / baseContentWidth)
                .clamp(0.7, 1.0);
            final double horizontalPadding = constraints.maxWidth < 420
                ? 12
                : (isWide ? 40 : 16);
            final double verticalPadding = constraints.maxHeight < 720
                ? 16
                : 24;
            final double sectionSpacing = 20 * density;
            final double blockSpacing = 24 * density;
            final double titleFontSize = (34 * density).clamp(24.0, 34.0);
            final double cardRadius = (16 * density).clamp(12.0, 16.0);
            final double cardPaddingVertical = (40 * density).clamp(28.0, 40.0);
            final double cardPaddingHorizontal = (24 * density).clamp(
              16.0,
              24.0,
            );
            final double categoriaFontSize = (28 * density).clamp(20.0, 28.0);
            final double imcFontSize = (60 * density).clamp(38.0, 60.0);
            final double descriptionPadding = (16 * density).clamp(12.0, 16.0);
            final double descriptionFontSize = (16 * density).clamp(13.0, 16.0);
            final double descriptionLineHeight = 1.3 + (1 - density) * 0.2;

            return Align(
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: verticalPadding,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: isWide ? 800 : 520),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "Tu resultado",
                        style: TextStyle(
                          fontSize: titleFontSize,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: sectionSpacing),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.backgroundsComponent,
                          borderRadius: BorderRadius.circular(cardRadius),
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: cardPaddingVertical,
                          horizontal: cardPaddingHorizontal,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              categoria,
                              style: TextStyle(
                                color: categoriaColor,
                                fontSize: categoriaFontSize,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: sectionSpacing),
                            Text(
                              imc.toStringAsFixed(2),
                              style: TextStyle(
                                fontSize: imcFontSize,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: sectionSpacing),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(descriptionPadding),
                              decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: SelectableText(
                                descripcion,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: descriptionFontSize,
                                  color: Colors.white70,
                                  height: descriptionLineHeight,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: blockSpacing),
                      CalculateButton(
                        buttonText: "Finalizar",
                        density: density,
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
