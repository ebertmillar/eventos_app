import 'package:flutter/material.dart';

class CustomOutlinedButton extends StatelessWidget {
  final void Function()? onPressed;
  final String? text;
  final Color? borderColor;
  final Color? textColor;
  final double? fontSize;
  final Widget? child;

  const CustomOutlinedButton({
    super.key,
    this.onPressed,
    required this.text,
    this.borderColor = Colors.black, // Color del borde
    this.textColor = Colors.black, // Color del texto
    this.fontSize = 18,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double buttonWidth = screenWidth * 0.6;

    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        foregroundColor: textColor, // Color del texto
        side: BorderSide(color: borderColor!, width: 1), // Borde con ancho
        textStyle: TextStyle(fontSize: fontSize, color: textColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Bordes redondeados
        ),
        padding: const EdgeInsets.symmetric(vertical: 20),
      ),
      onPressed: onPressed,
      child: SizedBox(
        width: buttonWidth, // Establece un ancho fijo para el botón
        child: Center(
          child: child ?? Text(text ?? ''),
        ),
      ),
    );
  }
}
