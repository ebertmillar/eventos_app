import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {

  final String label;
  final String? hint;
  final Color borderColor;

  const CustomTextFormField({
    super.key,
    required this.label,
    this.hint,
    this.borderColor = Colors.black, // Color por defecto
  });
  

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5.0, left: 10.0, right: 10.0),
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          TextFormField(
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: Colors.grey),
              border: InputBorder.none, // Sin borde visible
              contentPadding: const EdgeInsets.fromLTRB(10, 5, 10, 5), // Espaciado interno
              isDense: true,
            ),
            style: const TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }
}