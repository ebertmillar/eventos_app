import 'package:flutter/material.dart';

class CustomFilledButton extends StatelessWidget {

  final void Function()? onPressed;
  final String? text;
  final Color? buttonColor;
  final Color? textColor;
  final double? fontSize;
  final Widget? child;

  const CustomFilledButton({
    super.key, 
    this.onPressed, 
    required this.text, 
    this.buttonColor = Colors.black, 
    this.textColor = Colors.white, 
    this.fontSize = 18,
    this.child, 
  });

  @override
  Widget build(BuildContext context) {

    final double screenWidth = MediaQuery.of(context).size.width;
    final double buttonWidth = screenWidth * 0.6; 

    return FilledButton(
     
      style: FilledButton.styleFrom(
        backgroundColor: buttonColor,
        foregroundColor: textColor,
        textStyle: TextStyle(fontSize: fontSize),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),          
        ),
        padding: const EdgeInsets.symmetric(vertical: 20),
        disabledBackgroundColor: buttonColor, 

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