import 'dart:io';

import 'package:eventos_app/helpers/date_time_formatters.dart';
import 'package:eventos_app/helpers/form_date.dart';
import 'package:eventos_app/presentation/providers/create_event_form_provider.dart';
import 'package:eventos_app/presentation/shared/shared.dart';
import 'package:eventos_app/presentation/shared/widgets/custom_checkbox.dart';
import 'package:eventos_app/presentation/shared/widgets/custom_image_picker_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class DatosDelEventoForm extends ConsumerWidget {
  const DatosDelEventoForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final eventFormState = ref.watch(createEventFormProvider);
    //final formNotifier = ref.read(createEventFormProvider.notifier);

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
        CustomTextFormField(
          label: 'Decripción del evento',
          hint: 'Nombre oficial del evento',
          keyboardType: TextInputType.text,
          controller: ref.read(createEventFormProvider.notifier).nameController,
          onChanged: (value) => ref.read(createEventFormProvider.notifier).onNameChanged(value),
        ),

        CustomTextFormField(
          label: 'Nombre del evento',
          hint: 'Breve explicacion del tema...',
          keyboardType: TextInputType.text,
          maxLines: 4,
          controller: ref.read(createEventFormProvider.notifier).descriptionController,
          onChanged: ref.read(createEventFormProvider.notifier).onDescriptionChanged,
        ),
        
        Row(
          children: [
            Expanded(
              child: CustomTextFormField(
                label: 'Día de inicio',
                hint: '12/12/2020',
                keyboardType: TextInputType.text,
                controller: TextEditingController(
                  text: eventFormState.fechaInicio != null
                      ? formatDate(eventFormState.fechaInicio!)
                      : '',
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.calendar_today, color: Colors.black45, size: 25),
                  onPressed: () async {
                    final selectedDate = await _showDatePicker(context, eventFormState.fechaInicio);
                    if (selectedDate != null) {
                      ref.read(createEventFormProvider.notifier).onStartDateChanged(selectedDate);
                    }
                  },
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: CustomTextFormField(
                label: 'Día final',
                hint: 'dd/mm/yyyy',
                keyboardType: TextInputType.text,
                controller: TextEditingController(
                  text: eventFormState.fechaFin != null
                      ? formatDate(eventFormState.fechaFin!)
                      : '',
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.calendar_today, color: Colors.black45, size: 25),
                  onPressed: () async {
                    final selectedDate = await _showDatePicker(context, eventFormState.fechaFin);
                    if (selectedDate != null) {
                      ref.read(createEventFormProvider.notifier).onEndDateChanged(selectedDate);
                    }
                  },
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: CustomTextFormField(
                label: 'Hora de incio',
                hint: '12:00 PM',
                keyboardType: TextInputType.text,
                controller: TextEditingController(
                  text: eventFormState.horaInicio != null
                      ? formatTimeWithAMPM(eventFormState.horaInicio!)
                      : '',
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.access_time_outlined, color: Colors.black45, size: 25,),
                  onPressed: () async {
                    final selectedTime = await _showTimePicker(context, eventFormState);
                    if (selectedTime != null) {
                      ref.read(createEventFormProvider.notifier).onStartTimeChanged(selectedTime);
                    }                    
                  }
                ),               
              )
            ),
            const SizedBox(width: 10),
            Expanded(
              child: CustomTextFormField(
                label: 'Hora final',
                hint: '12:00 PM',
                keyboardType: TextInputType.text,
                controller: TextEditingController(
                  text: eventFormState.horaFin != null
                      ? formatTimeWithAMPM(eventFormState.horaFin!)
                      : '',
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.access_time_outlined, color: Colors.black45, size: 25,),
                  onPressed: () async {
                    final selectedTime = await _showTimePicker(context, eventFormState);
                    if (selectedTime != null) {
                      ref.read(createEventFormProvider.notifier).onEndTimeChanged(selectedTime);
                    }                    
                  }
                ),               
              )
            ),
          ],
        ),
        const SizedBox(height: 5),
        CustomCheckBox(
          label: '¿Cada día comienza  y termina a una hora distinta?', 
          value: eventFormState.horariosDiferentesPorDia ?? false,
          contentPadding: const EdgeInsets.symmetric(horizontal: 15),
          onChanged: (newValue) {
              ref.read(createEventFormProvider.notifier).onDifferentTimePerDayChanged(newValue ?? false);
            },
        ),

        CustomTextFormField(
          label: 'Ubicación',
          hint: 'Dirección física o virtual(link de la reunión)',
          controller: ref.read(createEventFormProvider.notifier).locationController,
          onChanged: ref.read(createEventFormProvider.notifier).onLocationChanged,
        ),

        CustomImagePickerField(
          label: 'Imagen de Cabecera',
          hint: 'Carga una imagen',
          imageName: ref.watch(createEventFormProvider).headerImageName, // Nombre de la imagen
          suffixIcon: IconButton(
            icon: const Icon(Icons.add_photo_alternate_outlined, color: Colors.black45, size: 25),
            onPressed: () async {
              final picker = ImagePicker();
              final pickedFile = await picker.pickImage(source: ImageSource.gallery);
              if (pickedFile != null) {
                final imageFile = File(pickedFile.path);
                ref.read(createEventFormProvider.notifier).onImageChanged(imageFile);
              }
            },
          ),
          onPickImage: () {},
        ),       
      ],
    );
  }

  Future<DateTime?> _showDatePicker(BuildContext context, DateTime? initialDate) {
    return showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
  }



  Future<TimeOfDay?> _showTimePicker(BuildContext context, EventFormState eventFormState) {
    return showTimePicker(
      context: context,
      initialEntryMode: TimePickerEntryMode.input,
      helpText: 'Introduce la hora',
      initialTime: eventFormState.horaInicio != null
        ? TimeOfDay(
            hour: eventFormState.horaInicio!.hour,
            minute: eventFormState.horaInicio!.minute,
          )
        : TimeOfDay.now(),
    );
  }
}
