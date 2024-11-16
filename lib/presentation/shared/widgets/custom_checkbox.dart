import 'package:flutter/material.dart';

class CustomCheckBox extends StatelessWidget {
  final String label;
  final bool value;
  final EdgeInsetsGeometry? contentPadding;
  final Function(bool?)? onChanged;

  const CustomCheckBox({
    super.key,
    required this.label,
    required this.value,
    this.onChanged, 
    this.contentPadding,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: contentPadding,
      visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Checkbox(
              value: value,  // Recibe el valor que pasamos
              onChanged: onChanged,  // Llama la función cuando cambia
              checkColor: Colors.white,
              activeColor: Colors.black,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,  // El texto del label
              style: const TextStyle(fontSize: 12, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}