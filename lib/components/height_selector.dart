import 'package:flutter/material.dart';
import 'package:imc_calculator/core/app_colors.dart';
import 'package:imc_calculator/core/text_stytles.dart';

class HeightSelector extends StatefulWidget {
  final int initialValue;
  final Function(double) onHeightChanged;
  final double density;

  const HeightSelector({
    super.key,
    required this.initialValue,
    required this.onHeightChanged,
    this.density = 1.0,
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
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isWide = constraints.maxWidth > 520;
        final double scale = widget.density.clamp(0.6, 1.0);
        final double padding = (16 * scale).clamp(12.0, 16.0);
        final double spacing = (12 * scale).clamp(8.0, 12.0);
        final double rowSpacing = (24 * scale).clamp(16.0, 24.0);
        final double valueFontSize = (38 * scale).clamp(28.0, 38.0);
        double trackHeight = (4 * scale).clamp(2.0, 4.0);
        final double radius = (16 * scale).clamp(12.0, 16.0);
        final double titleFontSize = (18 * scale).clamp(14.0, 18.0);

        final Widget header = Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "ALTURA",
              style: TextStyles.bodyText.copyWith(
                fontSize: titleFontSize,
                height: 1.2,
              ),
            ),
            SizedBox(height: spacing),
            Text(
              "$value cm",
              style: TextStyle(
                color: Colors.white,
                fontSize: valueFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        );

        final Widget slider = SliderTheme(
          data: SliderTheme.of(context).copyWith(trackHeight: trackHeight),
          child: Slider(
            value: value.toDouble(),
            onChanged: (newValue) {
              setState(() {
                value = newValue.toInt();
              });
              widget.onHeightChanged(newValue);
            },
            min: 150,
            max: 220,
            divisions: 70,
            activeColor: AppColors.primary,
          ),
        );

        return Container(
          decoration: BoxDecoration(
            color: AppColors.backgroundsComponent,
            borderRadius: BorderRadius.circular(radius),
          ),
          padding: EdgeInsets.all(padding),
          child: isWide
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(flex: 2, child: header),
                    SizedBox(width: rowSpacing),
                    Expanded(flex: 3, child: slider),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    header,
                    SizedBox(height: spacing),
                    slider,
                  ],
                ),
        );
      },
    );
  }
}
