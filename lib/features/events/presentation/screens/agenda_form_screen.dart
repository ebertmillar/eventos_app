import 'package:eventos_app/features/events/domain/entities/activity.dart';
import 'package:eventos_app/features/events/domain/entities/event.dart';
import 'package:eventos_app/shared/helpers/date_picker_helper.dart';
import 'package:eventos_app/shared/helpers/form_date.dart';
import 'package:eventos_app/features/events/presentation/providers/create_event_form_provider.dart';
import 'package:eventos_app/features/events/presentation/widgets/agenda/day_tile.dart';
import 'package:eventos_app/shared/widgets/custom_file_picker_field.dart';
import 'package:eventos_app/shared/widgets/custom_filled_button.dart';
import 'package:eventos_app/shared/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AgendaFormScreen extends ConsumerWidget {
  final Event? event;
  const AgendaFormScreen({super.key, this.event});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventFormState = ref.watch(createEventFormProvider(event!));
    final eventFormNotifier = ref.read(createEventFormProvider(event!).notifier);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Agenda',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          const SizedBox(height: 20),

          // Renderiza los días de la agenda
          if (eventFormState.agenda.isNotEmpty)
            ...eventFormState.agenda.map((day) {
              return DayTile(
                day: day,
                onDeleteDay: () => eventFormNotifier.removeDay(day.day),
                onAddActivity: (context, day) => _showAddActivityDialog(context, ref, day),
                onDeleteActivity: (day, index) => eventFormNotifier.removeActivity(day, index),
              );
            })
          else
            const Center(
              child: Text(
                'No hay días registrados en la agenda.',
                style: TextStyle(fontSize: 16, color: Colors.black45),
              ),
            ),

          const SizedBox(height: 10),

          // Botón para añadir otro día
          Center(
            child: CustomFilledButton(
              text: '+ Añadir otro día',
              textColor: Colors.orange[500],
              onPressed: () {
                if (_validateEventDates(context, ref)) {
                  _showAddDayDialog(context, ref);
                }
              },
            ),
          ),

          const SizedBox(height: 10),

          // Campo para información adicional
          CustomTextFormField(
            label: 'Información extra',
            hint: 'Añade toda la información adicional como comida, transporte, etc.',
            maxLines: 4,
            controller: eventFormNotifier.additionalInfoController,
            errorMessage: eventFormState.isEventAgendaPosted ? eventFormState.additionalInfo?.errorMessage : null, 
            onChanged: eventFormNotifier.onAdditionalInfoChanged,
          ),

          const SizedBox(height: 10),

          // Campo para adjuntar documentos
          FilePickerField(
            label: 'Adjunta documentos',
            hint: 'Adjunta cartelera, folletos, etc.',
            attachedFiles: eventFormState.attachedDocument ?? [],
            onFilesChanged: (files) {
              // Delegamos al notifier las acciones
              eventFormNotifier.onAttachedDocumentsChanged(files);
            },
            onRemoveFile: (index) {
              eventFormNotifier.removeFile(index);
            },
          ),

          const SizedBox(height: 10),
        ],
      ),
    );
  }

  bool _validateEventDates(BuildContext context, WidgetRef ref) {
    final eventFormState = ref.read(createEventFormProvider(event!));
    if (eventFormState.startDate.value == null || eventFormState.endDate.value == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Primero debes seleccionar una fecha de inicio y fin del evento.')),
      );
      return false;
    }
    return true;
  }

  

void _showAddDayDialog(BuildContext context, WidgetRef ref) async {
  final eventFormState = ref.read(createEventFormProvider(event!));
  final eventFormNotifier = ref.read(createEventFormProvider(event!).notifier);

  final selectedDate = await showDatePickerHelper(
    context: context,
    initialDate: eventFormState.startDate.value ?? DateTime.now(),
    firstDate: eventFormState.startDate.value ?? DateTime.now(),
    lastDate: eventFormState.endDate.value ?? DateTime.now().add(const Duration(days: 365)),
    helpText: 'Selecciona un día para el evento',
  );

  if (selectedDate != null) {
    try {
      final dayLabel = 'Día ${eventFormState.agenda.length + 1} (${formatDate(selectedDate)})';
      eventFormNotifier.addDay(dayLabel, selectedDate);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Día agregado exitosamente.')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString().replaceAll('Exception: ', ''))),
      );
    }
  }
}


  void _showAddActivityDialog(BuildContext context, WidgetRef ref, String date) {
    final startTimeController = TextEditingController();
    final endTimeController = TextEditingController();
    final titleController = TextEditingController();
    final eventFormNotifier = ref.read(createEventFormProvider(event!).notifier);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Agregar Actividad'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: 'Título'),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: startTimeController,
                        decoration: const InputDecoration(labelText: 'Inicio'),
                        readOnly: true,
                        onTap: () async {
                          final time = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (time != null) {
                            startTimeController.text = time.format(context);
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: endTimeController,
                        decoration: const InputDecoration(labelText: 'Fin'),
                        readOnly: true,
                        onTap: () async {
                          final time = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (time != null) {
                            endTimeController.text = time.format(context);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (titleController.text.isNotEmpty &&
                    startTimeController.text.isNotEmpty &&
                    endTimeController.text.isNotEmpty) {
                  final activity = Activity(
                    startTime: startTimeController.text,
                    endTime: endTimeController.text,
                    description: titleController.text,
                  );
                  eventFormNotifier.addActivity(date, activity);
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Completa todos los campos para agregar una actividad.')),
                  );
                }
              },
              child: const Text('Agregar'),
            ),
          ],
        );
      },
    );
  }
}
