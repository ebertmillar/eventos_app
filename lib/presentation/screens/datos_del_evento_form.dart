import 'package:eventos_app/presentation/shared/shared.dart';
import 'package:eventos_app/presentation/shared/widgets/custom_checkbox.dart';
import 'package:flutter/material.dart';

class DatosDelEventoForm extends StatelessWidget {
  const DatosDelEventoForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Datos del Evento',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const CustomTextFormField(
          label: 'Decripción del evento',
          hint: 'Nombre oficial del evento',
          keyboardType: TextInputType.text,
        ),

        const CustomTextFormField(
          label: 'Nombre del evento',
          hint: 'Breve explicacion del tema...',
          keyboardType: TextInputType.text,
          maxLines: 4,
        ),
        
        Row(
          children: [
            Expanded(
              child: CustomTextFormField(
                label: 'Dia de inicio',
                hint: 'dd/mm/yyyy',
                keyboardType: TextInputType.text,
                suffixIcon: IconButton(
                  icon: const Icon(Icons.calendar_today, color: Colors.black45, size: 25,),
                  onPressed: () {},
                ),

              )
            ),
            const SizedBox(width: 10),
            Expanded(
              child: CustomTextFormField(
                label: 'Dia final',
                hint: 'dd/mm/yyyy',
                keyboardType: TextInputType.text,
                suffixIcon: IconButton(
                  icon: const Icon(Icons.calendar_today, color: Colors.black45, size: 25,),
                  onPressed: () {},
                ),

              )
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: CustomTextFormField(
                label: 'Hora de incio',
                hint: 'dd/mm/yyyy',
                keyboardType: TextInputType.text,
                suffixIcon: IconButton(
                  icon: const Icon(Icons.access_time_outlined, color: Colors.black45, size: 25,),
                  onPressed: () {},
                ),

              )
            ),
            const SizedBox(width: 10),
            Expanded(
              child: CustomTextFormField(
                label: 'Hora final',
                hint: 'dd/mm/yyyy',
                keyboardType: TextInputType.text,
                suffixIcon: IconButton(
                  icon: const Icon(Icons.access_time_outlined, color: Colors.black45, size: 25,),
                  onPressed: () {},
                ),

              )
            ),
          ],
        ),
        const SizedBox(height: 5),
        const CustomCheckBox(
          label: '¿Cada día comienza  y termina a una hora distinta?', 
          value: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 15),
        ),

        CustomTextFormField(
          label: 'Ubicación',
          hint: 'Dirección física o virtual(link de la reunión)',
          onChanged: (value) {
            
          },
        ),

        CustomTextFormField(
          label: 'Imagen de Cabecera',
          hint: 'Carga una imagen',
          suffixIcon: IconButton(
            icon: const Icon(Icons.add_photo_alternate_outlined, color: Colors.black45, size: 25,),
            onPressed: () {},
          ),
          onChanged: (value) {
            
          },
        ),

        
        
      ],
    );
  }
}
