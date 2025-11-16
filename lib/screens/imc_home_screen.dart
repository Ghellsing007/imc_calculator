import 'package:flutter/material.dart';
import 'package:imc_calculator/components/calculate_button.dart';
import 'package:imc_calculator/components/gender_selector.dart';
import 'package:imc_calculator/components/height_selector.dart';
import 'package:imc_calculator/components/number_selector.dart';
import 'package:imc_calculator/core/app_colors.dart';
import 'package:imc_calculator/screens/imc_result_screen.dart';

class ImcHomeScreen extends StatefulWidget {
  const ImcHomeScreen({super.key});

  @override
  State<ImcHomeScreen> createState() => _ImcHomeScreenState();
}

class _ImcHomeScreenState extends State<ImcHomeScreen> {
  String _genero = "";
  int _peso = 0;
  int _edad = 0;
  int _altura = 160; // altura inicial

  // PESO
  void _incrementPeso(int newValue) {
    setState(() => _peso = newValue);
  }

  void _decrementPeso(int newValue) {
    setState(() => _peso = newValue);
  }

  // EDAD
  void _incrementEdad(int newValue) {
    setState(() => _edad = newValue);
  }

  void _decrementEdad(int newValue) {
    setState(() => _edad = newValue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgrounds,
      appBar: AppBar(title: const Text("IMC CALCULATOR")),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final bool isWide = constraints.maxWidth >= 700;
            const double baseContentWidth = 520;
            final double density = (constraints.maxWidth / baseContentWidth)
                .clamp(0.7, 1.0);
            final double horizontalPadding = constraints.maxWidth < 420
                ? 12
                : (isWide ? 40 : 16);
            final double verticalPadding = constraints.maxHeight < 720
                ? 16
                : 24;
            final double sectionSpacing = 16 * density;
            final double blockSpacing = 24 * density;
            final double rowSpacing = 16 * density;
            final EdgeInsets padding = EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: verticalPadding,
            );

            final Widget weightAndAge = isWide
                ? Row(
                    children: [
                      Expanded(
                        child: NumberSelector(
                          label: "PESO",
                          initialValue: _peso,
                          onIncrement: _incrementPeso,
                          onDecrement: _decrementPeso,
                          density: density,
                        ),
                      ),
                      SizedBox(width: rowSpacing),
                      Expanded(
                        child: NumberSelector(
                          label: "EDAD",
                          initialValue: _edad,
                          onIncrement: _incrementEdad,
                          onDecrement: _decrementEdad,
                          density: density,
                        ),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      NumberSelector(
                        label: "PESO",
                        initialValue: _peso,
                        onIncrement: _incrementPeso,
                        onDecrement: _decrementPeso,
                        density: density,
                      ),
                      SizedBox(height: rowSpacing),
                      NumberSelector(
                        label: "EDAD",
                        initialValue: _edad,
                        onIncrement: _incrementEdad,
                        onDecrement: _decrementEdad,
                        density: density,
                      ),
                    ],
                  );

            return Align(
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                padding: padding,
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: isWide ? 960 : 520),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      GenderSelector(
                        initialValue: _genero,
                        density: density,
                        onGenderChanged: (newGender) {
                          setState(() {
                            _genero = newGender;
                          });
                        },
                      ),
                      SizedBox(height: sectionSpacing),
                      HeightSelector(
                        initialValue: _altura,
                        density: density,
                        onHeightChanged: (newHeight) {
                          setState(() {
                            _altura = newHeight.toInt();
                          });
                        },
                      ),
                      SizedBox(height: sectionSpacing),
                      weightAndAge,
                      SizedBox(height: blockSpacing),
                      CalculateButton(
                        buttonText: "CALCULAR",
                        density: density,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ImcResultScreen(
                                genero: _genero,
                                peso: _peso,
                                edad: _edad,
                                altura: _altura,
                              ),
                            ),
                          );
                        },
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
