import 'package:flutter/material.dart';

class CustomDropdownFormField extends StatelessWidget {
  final String? label;
  final String? hint;
  final List<String>? items;
  final String? selectedValue;
  final String? errorMessage;
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
    this.errorMessage,
    this.onChanged, 
    this.borderColor = Colors.black, 
    this.labelColor = Colors.black, 
    this.itemsColor = Colors.black54,
    this.hintColor = Colors.black54, 
  });

  @override
  Widget build(BuildContext context) {
    bool hasError = errorMessage != null && errorMessage!.isNotEmpty; // Determinamos si hay un error

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Container que envuelve el Dropdown
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: hasError ? Colors.red : borderColor), // Borde rojo si hay error
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButtonFormField<String>(
                  value: selectedValue,
                  hint: Text(
                    hint ?? 'Seleccione una opción', 
                    style: TextStyle(
                      fontSize: 14, 
                      color: hasError ? Colors.red[800] : hintColor, // Cambiar color a rojo si hay error
                    ),
                  ),
                  items: items?.map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item, style: TextStyle(fontSize: 14, color: itemsColor)),
                    );
                  }).toList(),
                  onChanged: onChanged,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(top: 25, left: 10, bottom: 10), // Ajuste a 10 para menos padding en la izquierda
                    border: InputBorder.none, // Remover el borde predeterminado
                  ),
                  iconEnabledColor: hasError ? Colors.red[800] : Colors.black, // Cambiar color de la flecha si hay error
                ),
              ),
              // Label posicionado en la parte superior
              if (label != null)
                Positioned(
                  left: 10,
                  top: 5, // Ajuste para el label
                  child: Text(
                    label!,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: hasError ? Colors.red[800] : labelColor, // Cambiar color a rojo si hay error
                    ),
                  ),
                ),
            ],
          ),
          // Si hay un mensaje de error, se mostrará fuera del contenedor
          if (hasError)
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 2),
              child: Text(
                errorMessage!,
                style: TextStyle(
                  color: Colors.red[800],
                  fontSize: 12,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
