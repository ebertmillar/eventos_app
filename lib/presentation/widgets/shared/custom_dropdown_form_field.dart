import 'package:flutter/material.dart';

class CustomDropdownFormField extends StatelessWidget {
  final String? label;
  final String? hint;
  final List<String>? items;
  final String? selectedValue;
  final ValueChanged<String?>? onChanged;
  final Color borderColor;
  final Color labelColor;
  final Color itemsColor;
  final Color hintColor;

  const CustomDropdownFormField({
    super.key,
    this.label,
    this.hint,
    this.items,
    this.selectedValue,
    this.onChanged, 
    this.borderColor = Colors.black, 
    this.labelColor = Colors.black, 
    this.itemsColor = Colors.black54,
    this.hintColor = Colors.black54,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Stack(
        children: [
          // Container que envuelve el Dropdown
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: borderColor), // Borde del contenedor
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButtonFormField<String>(
              value: selectedValue,
              hint: Text(hint ??  'Seleccione una opción', style: TextStyle(fontSize: 14, color: hintColor),),
              items: items?.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item, style: TextStyle(fontSize: 14, color: itemsColor)),
                );
              }).toList(),
              onChanged: onChanged,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.only(top: 25, left: 10, bottom: 10), // Ajuste del padding
                border: InputBorder.none, // Remover el borde predeterminado
              ),
            ),
          ),
          // Label posicionado en la parte superior
          if (label != null) // Solo muestra el label si no es nulo
            Positioned(
              left: 10,
              top: 5, // Ajuste para el label
              child: Text(
                label!,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: labelColor,
                ),
              ),
            ),
        ],
      ),
    );
  }
}