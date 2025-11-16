import 'package:flutter/material.dart';
import 'package:imc_calculator/core/app_colors.dart';
import 'package:imc_calculator/core/text_stytles.dart';

class NumberSelector extends StatefulWidget {
  final String label;
  final int initialValue;
  final Function(int) onIncrement;
  final Function(int) onDecrement;

  const NumberSelector({
    super.key,
    required this.label,
    required this.initialValue,
    required this.onIncrement,
    required this.onDecrement,
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

    controller.addListener(() {
      final text = controller.text;
      if (text.isNotEmpty && int.tryParse(text) != null) {
        setState(() {
          value = int.parse(text);
        });
      }
    });
  }

  @override
  void didUpdateWidget(NumberSelector oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.initialValue != widget.initialValue) {
      value = widget.initialValue;
      controller.text = value.toString();
    }
  }

  @override
  void dispose() {
    controller.dispose(); // ← IMPORTANTE
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundsComponent,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(widget.label, style: TextStyles.bodyText),
          SizedBox(height: 8),

          SizedBox(
            width: 80,
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 34,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
              onChanged: (text) {
                if (int.tryParse(text) != null) {
                  widget.onIncrement(int.parse(text));
                }
              },
            ),
          ),

          SizedBox(height: 8),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (value > 0) {
                      value--;
                      controller.text = value.toString();
                      widget.onDecrement(value);
                    }
                  });
                },
                child: _circleButton(Icons.remove),
              ),
              SizedBox(width: 20),
              GestureDetector(
                onTap: () {
                  setState(() {
                    value++;
                    controller.text = value.toString();
                    widget.onIncrement(value);
                  });
                },
                child: _circleButton(Icons.add),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _circleButton(IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primary,
        shape: BoxShape.circle,
      ),
      padding: EdgeInsets.all(16),
      child: Icon(icon, color: Colors.white, size: 28),
    );
  }
}
