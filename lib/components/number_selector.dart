import 'package:flutter/material.dart';
import 'package:imc_calculator/core/app_colors.dart';
import 'package:imc_calculator/core/text_stytles.dart';

class NumberSelector extends StatefulWidget {
  final String label; // Recibe el texto que indica el tipo de valor
  final int initialValue; // Valor inicial para el selector
  final Function(int) onIncrement; // Función para incrementar el valor
  final Function(int) onDecrement; // Función para decrementar el valor

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
  late String label; // Variable para el label (input1)
  late int value; // Variable para el valor que cambia

  @override
  void initState() {
    super.initState();
    label = widget.label;  // Inicializamos el label con el valor pasado
    value = widget.initialValue;  // Inicializamos el valor con el valor pasado
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundsComponent,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: EdgeInsets.all(16), // Agregamos padding para mejorar el layout
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(label, style: TextStyles.bodyText),  // Mostrar el label (input1)
          Text(
            "$value", // Mostrar el valor de la variable
            style: TextStyle(
              color: Colors.white,
              fontSize: 38,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center, // Centrado de los botones
            children: [
              // Botón de "menos"
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (value > 0) {
                      value--; // Decrementar el valor
                      widget.onDecrement(value); // Llamamos a la función de decremento
                    }
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.primary, // Color de fondo
                    borderRadius: BorderRadius.circular(50), // Hacer el fondo circular
                  ),
                  padding: EdgeInsets.all(16), // Padding para ajustar el tamaño del contenedor
                  child: Icon(
                    Icons.remove,
                    size: 30, // Tamaño del ícono
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(width: 20), // Espacio entre los botones
              // Botón de "más"
              GestureDetector(
                onTap: () {
                  setState(() {
                    value++; // Incrementar el valor
                    widget.onIncrement(value); // Llamamos a la función de incremento
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.primary, // Color de fondo
                    borderRadius: BorderRadius.circular(50), // Hacer el fondo circular
                  ),
                  padding: EdgeInsets.all(16), // Padding para ajustar el tamaño del contenedor
                  child: Icon(
                    Icons.add,
                    size: 30, // Tamaño del ícono
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
