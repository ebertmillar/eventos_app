import 'package:flutter/material.dart';

class CustomRadiobutton extends StatelessWidget {
  final String label;
  final bool value;
  final bool groupValue;
  final Function(bool) onChanged;

  const CustomRadiobutton({
    super.key,
    required this.label,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => onChanged(value),
            child: Container(
              padding: const EdgeInsets.all(2), // Espacio entre los cuadrados
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black, width: 1),
                borderRadius: BorderRadius.circular(4), // Borde externo cuadrado
              ),
              child: Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(                
                  border: Border.all(color: Colors.black54, width: 2),
                  borderRadius: BorderRadius.circular(2), // Borde interno cuadrado
                  color: value == groupValue ? Colors.black : Colors.white,
                ),
                child: value == groupValue
                    ? const Center(
                        child: Icon(Icons.check, size: 14, color: Colors.white),
                      )
                    : null,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: GestureDetector(
              onTap: () => onChanged(value),
              child: Text(
                label,
                style: const TextStyle(fontSize: 12, color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
