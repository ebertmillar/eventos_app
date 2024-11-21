  import 'dart:io';

  import 'package:eventos_app/shared/helpers/date_picker_helper.dart';
  import 'package:eventos_app/shared/helpers/time_picker_helper.dart';
  import 'package:eventos_app/features/events/presentation/providers/create_event_form_provider.dart';
  import 'package:eventos_app/shared/shared.dart';
  import 'package:eventos_app/shared/widgets/custom_checkbox.dart';
  import 'package:eventos_app/features/events/presentation/widgets/custom_image_picker_field.dart';
  import 'package:flutter/material.dart';
  import 'package:flutter_riverpod/flutter_riverpod.dart';
  import 'package:image_picker/image_picker.dart';

  class DatosDelEventoForm extends ConsumerWidget {
    const DatosDelEventoForm({super.key});

    @override
    Widget build(BuildContext context, WidgetRef ref) {

      final eventFormState = ref.watch(createEventFormProvider);
      final eventFormNotifier = ref.read(createEventFormProvider.notifier);

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
            controller: eventFormNotifier.nameController,
            errorMessage: eventFormState.isEventInfoPosted ? eventFormState.name.errorMessage : null,
            onChanged: (value) => eventFormNotifier.onNameChanged(value),
          ),

          CustomTextFormField(
            label: 'Nombre del evento',
            hint: 'Breve explicacion del tema...',
            keyboardType: TextInputType.text,
            maxLines: 4,
            errorMessage: eventFormState.isEventInfoPosted ? eventFormState.description.errorMessage : null,
            controller: eventFormNotifier.descriptionController,
            onChanged: eventFormNotifier.onDescriptionChanged,
          ),
          
          Row(
            children: [
              Expanded(
                child: CustomTextFormField(
                  label: 'Día de inicio',
                  hint: '12/12/2020',
                  keyboardType: TextInputType.text,
                  controller: eventFormNotifier.startDateController,
                  errorMessage: eventFormState.isEventInfoPosted ? eventFormState.startDate.errorMessage : null ,
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_today, color: Colors.black45, size: 25),
                    onPressed: () async {
                      final selectedDate = await showDatePickerHelper(
                        context: context,
                        initialDate: eventFormState.startDate.value,
                        helpText: 'Selecciona una fecha', // Puedes personalizar esto
                      );
                      if (selectedDate != null) {
                      eventFormNotifier.onStartDateChanged(selectedDate);
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
                  keyboardType: TextInputType.text,
                  controller: eventFormNotifier.endDateController,
                  errorMessage: eventFormState.isEventInfoPosted ? eventFormState.endDate.errorMessage : null,
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_today, color: Colors.black45, size: 25),
                    onPressed: () async {
                      final selectedDate = await showDatePickerHelper(
                        context: context,
                        initialDate: eventFormState.endDate.value,
                        helpText: 'Selecciona una fecha', // Puedes personalizar esto
                      ); 
                      selectedDate != null ? eventFormNotifier.onEndDateChanged(selectedDate) : null;

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
                  controller: eventFormNotifier.startTimeController,
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.access_time_outlined, color: Colors.black45, size: 25,),
                    onPressed: () async {
                      final selectedTime = await showTimePickerHelper(
                        context: context,
                        initialTime: eventFormState.startTime, 
                        helpText: 'Selecciona la hora', 
                      );
                      if (selectedTime != null) {
                        eventFormNotifier.onStartTimeChanged(selectedTime);
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
                  controller: eventFormNotifier.endTimeController,
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.access_time_outlined, color: Colors.black45, size: 25,),
                    onPressed: () async {
                      final selectedTime = await showTimePickerHelper(
                        context: context,
                        initialTime: eventFormState.endTime, 
                        helpText: 'Selecciona la hora', 
                      );
                      if (selectedTime != null) {
                        eventFormNotifier.onEndTimeChanged(selectedTime);
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
            value: eventFormState.differentSchedulesPerDay ?? false,
            contentPadding: const EdgeInsets.symmetric(horizontal: 15),
            onChanged: (newValue) {
                eventFormNotifier.onDifferentTimePerDayChanged(newValue ?? false);
              },
          ),

          CustomTextFormField(
            label: 'Ubicación',
            hint: 'Dirección física o virtual(link de la reunión)',
            controller: eventFormNotifier.locationController,
            errorMessage: eventFormState.location.errorMessage,
            onChanged: eventFormNotifier.onLocationChanged,
          ),

          CustomImagePickerField(
            label: 'Imagen de Cabecera',
            hint: 'Carga una imagen',
            imageName: ref.watch(createEventFormProvider).headerImageName,
            errorMessage: eventFormState.isEventInfoPosted ? eventFormState.headerImage.errorMessage : null,
            suffixIcon: IconButton(
              icon: const Icon(Icons.add_photo_alternate_outlined, color: Colors.black45, size: 25),
              onPressed: () async {
                final picker = ImagePicker();
                final pickedFile = await picker.pickImage(source: ImageSource.gallery);
                if (pickedFile != null) {
                  final imageFile = File(pickedFile.path);
                  eventFormNotifier.onImageChanged(imageFile);
                }
              },
            ),
            onPickImage: () {},
          ),       
        ],
      );
    }


  }
