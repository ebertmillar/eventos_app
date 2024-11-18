import 'package:flutter/material.dart';

class CustomAttachmentField extends StatelessWidget {
  final String label;
  final String? hint;
  final Widget button;

  const CustomAttachmentField({
    Key? key,
    required this.label,
    this.hint,
    required this.button,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Stack(
        children: [
          // Caja principal (basada en CustomTextFormField)
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black45),
              borderRadius: BorderRadius.circular(5),
            ),
            padding: const EdgeInsets.only(left: 10, top: 30, right: 10, bottom: 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Etiqueta
                Text(
                  label,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),

                // Hint
                Text(
                  hint ?? 'Adjunta cartelería, folletos, etc.',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),

          // Botón centrado dentro del contenedor
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: button,
            ),
          ),
        ],
      ),
    );
  }
}
