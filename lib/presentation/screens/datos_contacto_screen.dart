import 'package:eventos_app/presentation/shared/shared.dart';
import 'package:eventos_app/presentation/shared/widgets/custom_checkbox.dart';
import 'package:flutter/material.dart';

class DatosContactoScreen extends StatelessWidget {
  const DatosContactoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Datos de Contacto',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),

        CustomTextFormField(
          label: 'Organizador',
          hint: 'Nombre del organizador o empresa',
          keyboardType: TextInputType.text,
        ),
        
        CustomTextFormField(
          label: 'Email',
          hint: 'Email del responsable del evento',
          keyboardType: TextInputType.text,
        ),
        CustomTextFormField(
          label: 'Teléfono de contacto',
          hint: 'Teléfono del responsable del evento',
          keyboardType: TextInputType.text,
        ),
        CustomTextFormField(
          label: 'Página web',
          hint: 'Añade URL del evento',
          keyboardType: TextInputType.text,
        ),
        CustomTextFormField(
          label: '¿Tienes Instagram?',
          hint: 'Añade tu @user o URL',
          keyboardType: TextInputType.text,
        ),
        CustomTextFormField(
          label: '¿Tienes Facebook?',
          hint: 'Añade tu @user o URL',
          keyboardType: TextInputType.text,
        ),
        CustomTextFormField(
          label: '¿Tienes Youtube?',
          hint: 'Añade tu @user o URL',
          keyboardType: TextInputType.text,
        ),
        CustomTextFormField(
          label: '¿Tienes Linkedin?',
          hint: 'Añade tu @user o URL',
          keyboardType: TextInputType.text,
        ),

        SizedBox(height: 10)


        

        
        
      ],
    );
  }
}
