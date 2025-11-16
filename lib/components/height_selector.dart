import 'package:flutter/material.dart';
import 'package:imc_calculator/core/app_colors.dart';
import 'package:imc_calculator/core/text_stytles.dart';

class HeightSelector extends StatefulWidget {
  final int initialValue;
  final Function(double) onHeightChanged;

  const HeightSelector({
    super.key,
    required this.initialValue,
    required this.onHeightChanged,
  });

  @override
  State<HeightSelector> createState() => _HeightSelectorState();
}

class _HeightSelectorState extends State<HeightSelector> {
  late int value;

  @override
  void initState() {
    super.initState();
    value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.backgroundsComponent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Text("ALTURA", style: TextStyles.bodyText),
              SizedBox(height: 10),
              Text(
                "$value cm",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Slider(
                value: value.toDouble(),
                onChanged: (newValue) {
                  setState(() {
                    value = newValue.toInt();     // ACTUALIZA LA UI
                  });

                  widget.onHeightChanged(newValue); // ENVÍA EL VALOR AL HOME
                },
                min: 150,
                max: 220,
                divisions: 70,
                activeColor: AppColors.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
