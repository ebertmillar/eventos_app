import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {

  

  final String label;
  final String? hint;
  final Color borderColor;
  final String? errorMessage;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;


  const CustomTextFormField({
    super.key, 
    required this.label,
    this.hint,
    this.borderColor = Colors.black,
    this.errorMessage,
    this.keyboardType = TextInputType.text ,
    this.onChanged, 
  });
  
  @override
  Widget build(BuildContext context) {

    final outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(color: borderColor) ,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Stack(
        children: [
          TextFormField(
            onChanged: onChanged,
            textAlignVertical: TextAlignVertical.bottom,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(fontSize: 14, 
              color: errorMessage != null ? Colors.red.shade800 : Colors.black54,), 
              isDense: true,
              errorText: errorMessage,
              contentPadding: const EdgeInsets.only(top: 30, left: 10, bottom: 5),
              enabledBorder: outlineInputBorder,
              focusedBorder: outlineInputBorder.copyWith(borderSide: const BorderSide(width: 2)),       
              focusedErrorBorder: outlineInputBorder.copyWith(borderSide: BorderSide(color:Colors.red.shade800, width: 2),),              
              errorBorder: outlineInputBorder.copyWith(borderSide: BorderSide(color:Colors.red.shade800, width: 1),),
            ),

            style: TextStyle(
              fontSize: 14,
              color: errorMessage != null ? Colors.red.shade800 : Colors.black87,
            ),
          ),
          
          Positioned(
            left: 10,
            top: 5, // Mantén esta posición para el label
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold, 
                fontSize: 14, 
                color: errorMessage != null ? Colors.red.shade800 : Colors.black87,), // Estilo del label
            ),
          ),          
        ],
      ),
    );
  }
}