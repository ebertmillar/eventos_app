import 'package:flutter/material.dart';

class CustomImagePickerField extends StatelessWidget {
  final String label;
  final String hint;
  final String? imageName;
  final Widget? suffixIcon;
  final VoidCallback onPickImage;

  const CustomImagePickerField({
    Key? key,
    required this.label,
    required this.hint,
    required this.onPickImage,
    this.imageName,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Stack(
        children: [
          // Contenedor que simula el campo de texto
          Container(
            width: double.infinity, // Ocupar todo el ancho disponible
            padding: const EdgeInsets.only(top: 30, left: 10, bottom: 5, right: 45),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black45, width: 1),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              imageName ?? hint,
              style: TextStyle(
                fontSize: 14,
                color: imageName != null ? Colors.black87 : Colors.black54,
              ),
            ),
          ),

          // Label en la parte superior izquierda
          Positioned(
            left: 10,
            top: 5,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
          ),

          // Icono de carga de imagen en la parte derecha
          Positioned(
            right: 5,
            bottom: 10,
            child: suffixIcon ??
                IconButton(
                  icon: const Icon(Icons.add_photo_alternate_outlined, color: Colors.black45, size: 25),
                  onPressed: onPickImage,
                ),
          ),
        ],
      ),
    );
  }
}
