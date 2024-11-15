  import 'package:eventos_app/presentation/shared/shared.dart';
  import 'package:flutter/material.dart';

  class AgendaFormScreen extends StatelessWidget {
    const AgendaFormScreen({super.key});

    @override
    Widget build(BuildContext context) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Agenda',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const CustomTextFormField(
            label: 'Dia 1',
            hint: 'Incluye el horario de cada dia',
            maxLines: 5,
            keyboardType: TextInputType.text,
          ),

          const SizedBox(height: 10),

          Center(
            child: CustomFilledButton(
              text: '+ Añadir otro dia',
              textColor: Colors.orange[400],
              buttonColor: Colors.black87,
              onPressed: (){}
            ),
          ),

          const SizedBox(height: 10),

          const CustomTextFormField(
            label: 'Información extra',
            hint: 'Añade toda la informaciíon adicional como comida, transporte, etc.',
            maxLines: 5,
            keyboardType: TextInputType.text,
          ),

          // Campo "Adjuntar Documentos" con botón
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black45),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Adjuntar Documentos',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 15),
                const Text(
                  'Adjunta cartelería, folletos, etc.',
                  style: TextStyle(color: Colors.black54),
                ),
                const SizedBox(height: 10),

                // Botón "+ Añadir documentos" centrado
                Center(
                  child: CustomFilledButton(
                    text: '+ Añadir documentos',
                    textColor: Colors.orange[400],
                    buttonColor: Colors.black87,
                    onPressed: () {
                      // Acción para adjuntar documentos
                    },
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          CustomAttachmentField(
            label: 'Adjuntar Documentos',
            buttonText: '+ Añadir documentos',
            onAttachmentAdded: () {
              // Acción adicional cuando se agrega un adjunto (opcional)
            },
          ),
          const SizedBox(height: 20),
          

          
          
        ],
      );
    }
  }
