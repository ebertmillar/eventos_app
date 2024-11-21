import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class CustomPhoneFormField extends StatelessWidget {
  final String label;
  final String? hint;
  final Color borderColor;
  final PhoneNumber? initialValue;

  const CustomPhoneFormField({
    super.key,
    required this.label,
    this.hint,
    this.borderColor = Colors.black,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5.0, left: 10.0, right: 10.0),
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          InternationalPhoneNumberInput(
            onInputChanged: (PhoneNumber number) {
                   
            },

            selectorConfig: const SelectorConfig(
                selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                setSelectorButtonAsPrefixIcon: true,
                leadingPadding: 10,                
                useBottomSheetSafeArea: true,
            ),

            selectorTextStyle: const TextStyle(color: Colors.black38),
            formatInput: false,
            keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: true),


            inputBorder: InputBorder.none,

            
            textStyle: const TextStyle(color:  Colors.black),
            maxLength: 9,
            spaceBetweenSelectorAndTextField: 20,

            inputDecoration: const InputDecoration(
              hintText: '555 555 555', // Cambia el texto del hint si lo necesitas
              hintStyle: TextStyle(color: Colors.grey), // Cambia el color del hint aquí
              border: InputBorder.none, // Asegúrate de mantener esta propiedad si no quieres bordes
            ),
            

            
          )
        ],
      ),
    );
  }
}