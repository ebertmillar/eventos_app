import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {

  final String label;
  final String? hint;
  final Color borderColor;
  final String? errorMessage;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final int? maxLines;
  final Widget? suffixIcon;
  final String? initialValue;


  const CustomTextFormField({
    super.key, 
    required this.label,
    this.hint,
    this.borderColor = Colors.black45,
    this.errorMessage,
    this.keyboardType = TextInputType.text ,
    this.onChanged,
    this.inputFormatters, 
    this.controller,
    this.maxLines = 1, 
    this.suffixIcon,
    this.initialValue,
    
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
            initialValue: initialValue,        
            maxLines: maxLines,
            onChanged: onChanged,
            controller: controller,
            inputFormatters: inputFormatters, 
            textAlignVertical: TextAlignVertical.bottom,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white, 
              hintText: hint,
              hintStyle: TextStyle(fontSize: 14, 
              color: errorMessage != null ? Colors.red.shade800 : Colors.black54,), 
              isDense: true,
              suffixIcon: suffixIcon,
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

