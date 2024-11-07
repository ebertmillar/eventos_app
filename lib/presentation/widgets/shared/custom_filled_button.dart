import 'package:flutter/material.dart';

class CustomFilledButton extends StatelessWidget {

  final void Function()? onPressed;
  final String text;
  final Color? buttonColor;
  final Color? textColor;
  final double? fontSize;

  const CustomFilledButton({
    super.key, 
    this.onPressed, 
    required this.text, 
    this.buttonColor = Colors.black, 
    this.textColor = Colors.white, 
    this.fontSize = 18
  });

  @override
  Widget build(BuildContext context) {

    return FilledButton(
     
      style: FilledButton.styleFrom(
        backgroundColor: buttonColor,
        foregroundColor: textColor,
        textStyle: TextStyle(fontSize: fontSize),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),          
        ),
        padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 20)

      ), 
      onPressed: onPressed, 
      child: Text(text),
    );
  }
}