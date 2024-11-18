import 'package:flutter/material.dart';

class CustomImagePickerField extends StatelessWidget {
  final String label;
  final String hint;
  final VoidCallback onPickImage;
  final String? imageName; // Nombre de la imagen cargada, si existe
  final Widget? suffixIcon;

  const CustomImagePickerField({
    super.key,
    required this.label,
    required this.hint,
    required this.onPickImage,
    this.imageName,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Stack(
        children: [
          // Contenedor que simula el campo de texto
          Container(
            width: double.infinity, // Ocupa todo el ancho disponible
            padding: const EdgeInsets.only(top: 25, left: 10, bottom: 5, right: 45),
            decoration: BoxDecoration(
              color: Colors.white,
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

          // Icono de carga de imagen en el centro de la altura del Container
          Positioned(
            right: 5,
            top: 0,
            bottom: 0,
            child: Center(
              child: suffixIcon ??
                  IconButton(
                    icon: const Icon(Icons.add_photo_alternate_outlined, color: Colors.black45, size: 25),
                    onPressed: onPickImage,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
