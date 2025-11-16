import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:imc_calculator/core/app_colors.dart';
import 'package:imc_calculator/core/text_stytles.dart';

class NumberSelector extends StatefulWidget {
  final String label;
  final int initialValue;
  final Function(int) onIncrement;
  final Function(int) onDecrement;
  final double density;

  const NumberSelector({
    super.key,
    required this.label,
    required this.initialValue,
    required this.onIncrement,
    required this.onDecrement,
    this.density = 1.0,
  });

  @override
  State<NumberSelector> createState() => _NumberSelectorState();
}

class _NumberSelectorState extends State<NumberSelector> {
  late int value;
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    value = widget.initialValue;
    controller = TextEditingController(text: value.toString());
  }

  @override
  void didUpdateWidget(covariant NumberSelector oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialValue != widget.initialValue &&
        widget.initialValue != value) {
      _updateValue(widget.initialValue);
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _updateValue(int newValue) {
    setState(() {
      value = newValue;
      controller.value = TextEditingValue(
        text: newValue.toString(),
        selection: TextSelection.collapsed(offset: newValue.toString().length),
      );
    });
  }

  void _increment() {
    final int newValue = value + 1;
    _updateValue(newValue);
    widget.onIncrement(newValue);
  }

  void _decrement() {
    if (value == 0) return;
    final int newValue = value - 1;
    _updateValue(newValue);
    widget.onDecrement(newValue);
  }

  @override
  Widget build(BuildContext context) {
    final double scale = widget.density.clamp(0.6, 1.0);

    return LayoutBuilder(
      builder: (context, constraints) {
        final double fieldWidth =
            (constraints.maxWidth > 220 ? 140 : 100) * scale;
        final double containerPadding = (16 * scale).clamp(10.0, 16.0);
        final double spacing = (8 * scale).clamp(6.0, 8.0);
        final double fontSize = (34 * scale).clamp(24.0, 34.0);
        final double buttonSpacing = (20 * scale).clamp(12.0, 20.0);
        final TextStyle labelStyle = TextStyles.bodyText.copyWith(
          fontSize: 18 * scale,
          height: 1.1 + (1 - scale) * 0.2,
        );

        return Container(
          decoration: BoxDecoration(
            color: AppColors.backgroundsComponent,
            borderRadius: BorderRadius.circular(16),
          ),
          padding: EdgeInsets.all(containerPadding),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(widget.label, style: labelStyle),
              SizedBox(height: spacing),
              SizedBox(
                width: fieldWidth,
                child: TextField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: fontSize,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: const InputDecoration(border: InputBorder.none),
                  onChanged: (text) {
                    if (text.isEmpty) return;
                    final parsed = int.tryParse(text);
                    if (parsed != null) {
                      setState(() {
                        value = parsed;
                      });
                      widget.onIncrement(parsed);
                    }
                  },
                ),
              ),
              SizedBox(height: spacing),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _circleButton(Icons.remove, _decrement, scale),
                  SizedBox(width: buttonSpacing),
                  _circleButton(Icons.add, _increment, scale),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _circleButton(IconData icon, VoidCallback onTap, double scale) {
    final double padding = (16 * scale).clamp(12.0, 16.0);
    final double iconSize = (26 * scale).clamp(20.0, 26.0);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onTap,
          child: Container(
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            padding: EdgeInsets.all(padding),
            child: Icon(icon, color: Colors.white, size: iconSize),
          ),
        ),
      ),
    );
  }
}
