import 'package:flutter/material.dart';
import 'package:imc_calculator/components/calculate_button.dart';
import 'package:imc_calculator/components/gender_selector.dart';
import 'package:imc_calculator/components/height_selector.dart';
import 'package:imc_calculator/components/number_selector.dart';

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
    return Column(
      children: [
        GenderSelector(
  initialValue: _genero,
  onGenderChanged: (newGender) {
    setState(() {
      _genero = newGender;
    });
  },
),

SizedBox(height: 10),

        SizedBox(height: 10),

        // ALTURA
        HeightSelector(
          initialValue: _altura,
          onHeightChanged: (newHeight) {
            setState(() {
              _altura = newHeight.toInt();
            });
          },
        ),

        SizedBox(height: 10),

        // PESO Y EDAD
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              NumberSelector(
                label: "PESO",
                initialValue: _peso,
                onIncrement: _incrementPeso,
                onDecrement: _decrementPeso,
              ),
              SizedBox(width: 10),
              NumberSelector(
                label: "EDAD",
                initialValue: _edad,
                onIncrement: _incrementEdad,
                onDecrement: _decrementEdad,
              ),
            ],
          ),
        ),

        Spacer(),

        CalculateButton(
          buttonText: "CALCULAR",
          onPressed: () {
            print("Peso: $_peso   Edad: $_edad   Altura: $_altura  Genero: $_genero");
          },
        ),
      ],
    );
  }
}
