import 'package:flutter/material.dart';
import 'package:imc_calculator/core/app_colors.dart';
import 'package:imc_calculator/core/text_stytles.dart';

class GenderSelector extends StatefulWidget {
  final String initialValue;
  final Function(String) onGenderChanged;
  final double density;

  const GenderSelector({
    super.key,
    required this.initialValue,
    required this.onGenderChanged,
    this.density = 1.0,
  });

  @override
  State<GenderSelector> createState() => _GenderSelectorState();
}

class _GenderSelectorState extends State<GenderSelector> {
  late String selectedGender;

  @override
  void initState() {
    super.initState();
    selectedGender = widget.initialValue;
  }

  @override
  void didUpdateWidget(covariant GenderSelector oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialValue != widget.initialValue &&
        widget.initialValue != selectedGender) {
      selectedGender = widget.initialValue;
    }
  }

  void _selectGender(String gender) {
    setState(() {
      selectedGender = gender;
    });
    widget.onGenderChanged(gender);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool stackCards = constraints.maxWidth < 360;
        final double scale = widget.density.clamp(0.6, 1.0);
        final double spacing = (12 * scale).clamp(8.0, 12.0);

        final cards = [
          _GenderCard(
            label: "HOMBRE",
            assetPath: "assets/images/male.png",
            isSelected: selectedGender == "Hombre",
            onTap: () => _selectGender("Hombre"),
            isCompact: stackCards,
            density: scale,
          ),
          _GenderCard(
            label: "MUJER",
            assetPath: "assets/images/female.png",
            isSelected: selectedGender == "Mujer",
            onTap: () => _selectGender("Mujer"),
            isCompact: stackCards,
            density: scale,
          ),
        ];

        if (stackCards) {
          return Column(
            children: [
              cards[0],
              SizedBox(height: spacing),
              cards[1],
            ],
          );
        }

        return Row(
          children: [
            Expanded(child: cards[0]),
            SizedBox(width: spacing),
            Expanded(child: cards[1]),
          ],
        );
      },
    );
  }
}

class _GenderCard extends StatelessWidget {
  final String label;
  final String assetPath;
  final bool isSelected;
  final bool isCompact;
  final VoidCallback onTap;
  final double density;

  const _GenderCard({
    required this.label,
    required this.assetPath,
    required this.isSelected,
    required this.onTap,
    required this.isCompact,
    required this.density,
  });

  @override
  Widget build(BuildContext context) {
    final double scale = density.clamp(0.6, 1.0);
    final double radius = (16 * scale).clamp(12.0, 16.0);
    final double cardPadding = (16 * scale).clamp(10.0, 16.0);
    final double innerSpacing = (12 * scale).clamp(8.0, 12.0);
    final double baseIconHeight = isCompact ? 90 : 110;
    final double iconHeight = (baseIconHeight * scale).clamp(
      70.0,
      baseIconHeight.toDouble(),
    );
    final TextStyle textStyle = TextStyles.bodyText.copyWith(
      fontSize: (18 * scale).clamp(14.0, 18.0),
    );

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(radius),
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: EdgeInsets.all(cardPadding),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.backgroundsComponentSelected
                  : AppColors.backgroundsComponent,
              borderRadius: BorderRadius.circular(radius),
              border: Border.all(
                color: isSelected
                    ? AppColors.primary
                    : AppColors.backgroundsComponent,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: iconHeight,
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Image.asset(assetPath),
                  ),
                ),
                SizedBox(height: innerSpacing),
                Text(label, style: textStyle),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
