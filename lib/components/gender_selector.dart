import 'package:flutter/material.dart';
import 'package:imc_calculator/core/app_colors.dart';
import 'package:imc_calculator/core/text_stytles.dart';

class GenderSelector extends StatefulWidget {
  final String initialValue;              // Valor que viene del PADRE
  final Function(String) onGenderChanged; // Callback para enviar al PADRE

  const GenderSelector({
    super.key,
    required this.initialValue,
    required this.onGenderChanged,
  });

  @override
  State<GenderSelector> createState() => _GenderSelectorState();
}

class _GenderSelectorState extends State<GenderSelector> {
  late String selectedGender;

  @override
  void initState() {
    super.initState();

    // 👉 Inicializar el estado interno con lo que viene del padre
    selectedGender = widget.initialValue;
  }

  void _selectGender(String gender) {
    setState(() {
      selectedGender = gender;
    });

    // 👉 Avisar al padre que cambió el género
    widget.onGenderChanged(gender);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        /// ------------------------------
        ///      TARJETA: HOMBRE
        /// ------------------------------
        Expanded(
          child: GestureDetector(
            onTap: () => _selectGender("Hombre"),
            child: Padding(
              padding: const EdgeInsets.only(
                left: 16,
                top: 16,
                bottom: 16,
                right: 8,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: selectedGender == "Hombre"
                      ? AppColors.backgroundsComponentSelected
                      : AppColors.backgroundsComponent,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Image.asset("assets/images/male.png", height: 100),
                      const SizedBox(height: 10),
                      Text("HOMBRE", style: TextStyles.bodyText),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),

        /// ------------------------------
        ///      TARJETA: MUJER
        /// ------------------------------
        Expanded(
          child: GestureDetector(
            onTap: () => _selectGender("Mujer"),
            child: Padding(
              padding: const EdgeInsets.only(
                left: 8,
                top: 16,
                bottom: 16,
                right: 16,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: selectedGender == "Mujer"
                      ? AppColors.backgroundsComponentSelected
                      : AppColors.backgroundsComponent,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Image.asset("assets/images/female.png", height: 100),
                      const SizedBox(height: 10),
                      Text("MUJER", style: TextStyles.bodyText),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
