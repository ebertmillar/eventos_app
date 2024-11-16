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
            maxLines: maxLines,
            onChanged: onChanged,
            controller: controller,
            inputFormatters: inputFormatters, 
            textAlignVertical: TextAlignVertical.bottom,
            decoration: InputDecoration(
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

class CustomAttachmentField extends StatelessWidget {
  final String label;
  final String buttonText;
  final String? attachmentName;
  final VoidCallback onAttachmentAdded;

  const CustomAttachmentField({
    Key? key,
    required this.label,
    required this.buttonText,
    required this.onAttachmentAdded,
    this.attachmentName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black45),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),

          // Muestra el nombre del archivo adjunto o el hint
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.grey[200],
            ),
            child: Text(
              attachmentName ?? 'Adjunta cartelería, folletos, etc.',
              style: TextStyle(
                fontSize: 14,
                color: attachmentName != null ? Colors.black87 : Colors.black54,
              ),
            ),
          ),
          const SizedBox(height: 10),

          // Botón para añadir documentos
          Center(
            child: ElevatedButton(
              onPressed: onAttachmentAdded,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black87,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: Text(
                buttonText,
                style: const TextStyle(color: Colors.amberAccent),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
