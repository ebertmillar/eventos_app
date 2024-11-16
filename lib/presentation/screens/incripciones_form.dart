import 'package:eventos_app/domain/enum/payment_method.dart';
import 'package:eventos_app/presentation/providers/create_event_form_provider.dart';
import 'package:eventos_app/presentation/shared/shared.dart';
import 'package:eventos_app/presentation/shared/widgets/custom_checkbox.dart';
import 'package:eventos_app/presentation/shared/widgets/custom_radiobutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InscriptionsForm extends ConsumerWidget {
  const InscriptionsForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Inscripciones',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 10),
        
        // Fechas de inicio y final del período de inscripción
        Row(
          children: [
            Expanded(
              child: CustomTextFormField(
                label: 'Día de inicio',
                hint: 'dd/mm/yyyy',
                keyboardType: TextInputType.datetime,
                suffixIcon: IconButton(
                  icon: const Icon(Icons.calendar_today, color: Colors.black45, size: 25),
                  onPressed: () {},
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: CustomTextFormField(
                label: 'Día final',
                hint: 'dd/mm/yyyy',
                keyboardType: TextInputType.datetime,
                suffixIcon: IconButton(
                  icon: const Icon(Icons.calendar_today, color: Colors.black45, size: 25),
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),

        // Horas de inicio y final del período de inscripción
        Row(
          children: [
            Expanded(
              child: CustomTextFormField(
                label: 'Hora de inicio',
                hint: '12:00 PM',
                keyboardType: TextInputType.datetime,
                suffixIcon: IconButton(
                  icon: const Icon(Icons.access_time_outlined, color: Colors.black45, size: 25),
                  onPressed: () {},
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: CustomTextFormField(
                label: 'Hora final',
                hint: '12:00 PM',
                keyboardType: TextInputType.datetime,
                suffixIcon: IconButton(
                  icon: const Icon(Icons.access_time_outlined, color: Colors.black45, size: 25),
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),

        // Selección de evento público o privado
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black45),
            borderRadius: BorderRadius.circular(5),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), // Espacio interno para todo el contenido
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '¿El evento es público o privado?',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold), // Ajusta el estilo si es necesario
              ),
              const SizedBox(height: 10), // Espacio entre el texto y los checkboxes
              Row(
                mainAxisAlignment: MainAxisAlignment.center, // Centra los checkboxes horizontalmente
                children: [
                  IntrinsicWidth(
                    child: CustomRadiobutton(
                      label: 'Público', 
                      value: true, 
                      groupValue: ref.watch(createEventFormProvider).esPublico,
                      onChanged: (value) => ref.read(createEventFormProvider.notifier).onEventPublicChanged(value),
                    )
                  ),
                  const SizedBox(width: 50), // Espacio entre los checkboxes
                  IntrinsicWidth(
                    child: CustomRadiobutton(
                      label: 'Privado', 
                      value: false, 
                      groupValue: ref.watch(createEventFormProvider).esPublico,
                      onChanged: (value) => ref.read(createEventFormProvider.notifier).onEventPublicChanged(value),
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),

        // Campo de aforo del evento
        const CustomTextFormField(
          label: 'Aforo del evento',
          hint: 'Introduce el nº de entradas disponibles',
          keyboardType: TextInputType.number,
        ),

        // Campo de costo de inscripción
        const CustomTextFormField(
          label: 'Coste de la inscripción',
          hint: 'Introduce el precio de la entrada',
          keyboardType: TextInputType.number,
        ),

        // Selección de métodos de pago
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black45),
            borderRadius: BorderRadius.circular(5),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), // Espacio interno para todo el contenido
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '¿Qué método de pago vas a usar? Puedes elegir varios',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold), // Ajusta el estilo si es necesario
              ),
              const SizedBox(height: 10), // Espacio entre el texto y los checkboxes

              Column(
                children: MetodoPago.values.map((metodo) {
                  final metodoString = metodo.name;
                  return CustomCheckBox(
                    label: metodoString.replaceAllMapped(RegExp(r'([A-Z])'), (match) => ' ${match.group(0)}').trim(),
                    value: ref.watch(createEventFormProvider).metodosPago.contains(metodoString),
                    onChanged: (value) => ref.read(createEventFormProvider.notifier).onPaymentMethodsChanged(metodo, value ?? false),
                  );
                }).toList(),
              )

              // CustomCheckBox(
              //   label: 'Con tarjeta',
              //   value: true,
              //   onChanged: (value) => ref.read(createEventFormProvider.notifier).onDifferentTimePerDayChanged(newValue ?? false);
              // ),
              // CustomCheckBox(
              //   label: 'En efectivo',
              //   value: false,
              //   onChanged: (value) {},
              // ),
              // CustomCheckBox(
              //   label: 'G Pay / ApplePay',
              //   value: false,
              //   onChanged: (value) {},
              // ),
              // CustomCheckBox(
              //   label: 'Paypal',
              //   value: false,
              //   onChanged: (value) {},
              // ),
              // CustomCheckBox(
              //   label: 'Klarna',
              //   value: false,
              //   onChanged: (value) {},
              // ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // Restricción por edad
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black45),
            borderRadius: BorderRadius.circular(5),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), // Espacio interno para todo el contenido
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '¿Hay restricción por edad en este evento?',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold), // Ajusta el estilo si es necesario
              ),
              const SizedBox(height: 10), // Espacio entre el texto y los checkboxes
              Row(
                mainAxisAlignment: MainAxisAlignment.center, // Centra los checkboxes horizontalmente
                children: [
                  IntrinsicWidth(
                    child: CustomCheckBox(
                      label: 'Si',
                      value: true,
                      onChanged: (value) {},
                    ),
                  ),
                  const SizedBox(width: 20), // Espacio entre los checkboxes
                  IntrinsicWidth(
                    child: CustomCheckBox(
                      label: 'No',
                      value: false,
                      onChanged: (value) {},
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
