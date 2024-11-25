import 'package:flutter/material.dart';

class CustomFilledButton extends StatelessWidget {
  final void Function()? onPressed;
  final String? text;
  final Color? buttonColor;
  final Color? textColor;
  final double? fontSize;
  final Widget? child;
  final FontWeight? fontWeight;

  const CustomFilledButton({
    super.key,
    this.onPressed,
    this.text,
    this.buttonColor = Colors.black,
    this.textColor = Colors.orange,
    this.fontSize = 18,
    this.child,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double buttonWidth = screenWidth * 0.6;

    return FilledButton(
      style: FilledButton.styleFrom(
        backgroundColor: buttonColor,
        foregroundColor: textColor, // Color global del texto
        textStyle: TextStyle(
          fontSize: fontSize,
          color: textColor, // Garantiza el color del texto en el estilo
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(vertical: 20),
        disabledBackgroundColor: buttonColor,
      ),
      onPressed: onPressed,
      child: SizedBox(
        width: buttonWidth,
        child: Center(
          child: child ??
              Text(
                text ?? '',
                style: TextStyle(
                  color: textColor, // Forzar color del texto
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                ),
              ),
        ),
      ),
    );
  }
}
