import 'package:eventos_app/domain/enum/payment_method.dart';
import 'package:eventos_app/helpers/date_picker_helper.dart';
import 'package:eventos_app/helpers/time_picker_helper.dart';
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

    final eventFormState = ref.watch(createEventFormProvider);
    final eventFormNotifier = ref.read(createEventFormProvider.notifier);

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
                label: 'Día Incio',
                hint: '12/12/2020',
                keyboardType: TextInputType.text,
                controller: eventFormNotifier.inscriptionStartDateController,
                suffixIcon: IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () async {
                    final selectedDate = await showDatePickerHelper(
                      context: context,
                      initialDate: eventFormState.inscriptionStartDate,
                      helpText: 'Selecciona una fecha',
                    );
                    if (selectedDate != null) {
                      eventFormNotifier.onInscriptionStartDateChanged(selectedDate);
                    }
                  },
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: CustomTextFormField(
                label: 'Día final',
                hint: '12/12/2020',
                keyboardType: TextInputType.datetime,
                controller: eventFormNotifier.inscriptionEndDateController,
                suffixIcon: IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () async {
                    final selectedDate = await showDatePickerHelper(
                      context: context,
                      initialDate: eventFormState.inscriptionEndDate,
                      helpText: 'Selecciona la fecha de fin de inscripción',
                    );
                    if (selectedDate != null) {
                      eventFormNotifier.onIncriptionEndDateChanged(selectedDate);
                    }
                  },
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
                controller: eventFormNotifier.inscriptionStartTimeController,
                suffixIcon: IconButton(
                  icon: const Icon(Icons.access_time_outlined, color: Colors.black45, size: 25,),
                  onPressed: () async {
                    final selectedTime = await showTimePickerHelper(
                      context: context,
                      initialTime: eventFormState.inscriptionStartTime, 
                      helpText: 'Selecciona la hora', 
                    );
                    if (selectedTime != null) {
                      eventFormNotifier.onInscriptionStartTimeChanged(selectedTime);
                    }                    
                  }
                ),  
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: CustomTextFormField(
                label: 'Hora final',
                hint: '12:00 PM',
                keyboardType: TextInputType.datetime,
                controller: eventFormNotifier.inscriptionEndTimeController,
                suffixIcon: IconButton(
                  icon: const Icon(Icons.access_time_outlined, color: Colors.black45, size: 25,),
                  onPressed: () async {
                    final selectedTime = await showTimePickerHelper(
                      context: context,
                      initialTime: eventFormState.inscriptionEndTime, 
                      helpText: 'Selecciona la hora', 
                    );
                    if (selectedTime != null) {
                      eventFormNotifier.onInscriptionEndTimeChanged(selectedTime);
                    }                    
                  }
                ),  
              ),
            ),
          ],
        ),

        // Selección de evento público o privado
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black45),
            borderRadius: BorderRadius.circular(5),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), 
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '¿El evento es público o privado?',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold), 
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center, 
                children: [
                  IntrinsicWidth(
                    child: CustomRadiobutton(
                      label: 'Público', 
                      value: true, 
                      groupValue: ref.watch(createEventFormProvider).isPublic,
                      onChanged: (value) => ref.read(createEventFormProvider.notifier).onEventPublicChanged(value),
                    )
                  ),
                  const SizedBox(width: 50), // Espacio entre los checkboxes
                  IntrinsicWidth(
                    child: CustomRadiobutton(
                      label: 'Privado', 
                      value: false, 
                      groupValue: ref.watch(createEventFormProvider).isPublic,
                      onChanged: (value) => eventFormNotifier.onEventPublicChanged(value),
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),

        // Campo de aforo del evento
        CustomTextFormField(
          label: 'Aforo del evento',
          hint: 'Introduce el nº de entradas disponibles',
          keyboardType: TextInputType.number,
          controller: eventFormNotifier.eventCapacityController,
          onChanged: (value){
            final intValue = int.tryParse(value);
            intValue != null ? eventFormNotifier.onEventCapacityChanged(intValue) : null;
          } 
        ),

        // Campo de costo de inscripción
        CustomTextFormField(
          label: 'Coste de la inscripción',
          hint: 'Introduce el precio de la entrada',
          keyboardType: TextInputType.number,
          controller: eventFormNotifier.eventCostController,
          onChanged: (value){
            final doubleValue = double.tryParse(value);
            doubleValue != null ? eventFormNotifier.onCostChanged(doubleValue) : null;
          } 
        ),

        // Selección de métodos de pago
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black45),
            borderRadius: BorderRadius.circular(5),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), 
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '¿Qué método de pago vas a usar? Puedes elegir varios',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold), 
              ),

              const SizedBox(height: 10), 

              Column(
                children: MetodoPago.values.map((metodo) {
                  final metodoString = metodo.name;
                  return CustomCheckBox(
                    label: metodoString.replaceAllMapped(RegExp(r'([A-Z])'), (match) => ' ${match.group(0)}').trim(),
                    value: ref.watch(createEventFormProvider).paymentMethods.contains(metodoString),
                    onChanged: (value) => ref.read(createEventFormProvider.notifier).onPaymentMethodsChanged(metodo, value ?? false),
                  );
                }).toList(),
              )
            ],
          ),
        ),

        const SizedBox(height: 20),

        // Restricción por edad
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black45),
            borderRadius: BorderRadius.circular(5),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), 
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '¿Hay restricción por edad en este evento?',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold), 
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center, 
                children: [
                  IntrinsicWidth(
                    child: CustomRadiobutton(
                      label: 'Si', 
                      value: false, 
                      groupValue: ref.watch(createEventFormProvider).restriccionEdad,
                      onChanged: (value) => eventFormNotifier.onAgeRestrictionChanged(value),
                    )
                  ),
                  const SizedBox(width: 70), // Espacio entre los checkboxes
                  IntrinsicWidth(
                    child: CustomRadiobutton(
                      label: 'No', 
                      value: true, 
                      groupValue: ref.watch(createEventFormProvider).restriccionEdad,
                      onChanged: (value) => eventFormNotifier.onAgeRestrictionChanged(value),
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),

        const SizedBox(height:5),
      ],
    );
  }
}
