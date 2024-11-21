
import 'dart:io';
import 'package:eventos_app/features/auth/domain/entities/entities.dart';
import 'package:eventos_app/features/events/domain/entities/activity.dart';
import 'package:eventos_app/features/events/enum/payment_method.dart';
import 'package:eventos_app/shared/helpers/date_time_formatters.dart';
import 'package:eventos_app/shared/helpers/form_date.dart';
import 'package:eventos_app/shared/infrastucture/infractructure.dart';
import 'package:eventos_app/shared/inputs/event/additional_info.dart';
import 'package:eventos_app/shared/inputs/event/inscription_cost.dart';
import 'package:eventos_app/shared/inputs/event/inscription_end_date.dart';
import 'package:eventos_app/shared/inputs/event/inscription_start_date.dart';
import 'package:eventos_app/shared/inputs/event/payment_methods.dart';
import 'package:eventos_app/shared/inputs/event/venue_capacity%20copy.dart';
import 'package:eventos_app/shared/inputs/social_media.dart';
import 'package:eventos_app/shared/shared.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:intl/intl.dart';


final createEventFormProvider = 
  StateNotifierProvider.autoDispose<CreateEventFormNotifier, EventFormState>((ref) {
    return CreateEventFormNotifier();
});


class CreateEventFormNotifier extends StateNotifier<EventFormState>{
  CreateEventFormNotifier() : super(EventFormState()){

    startDateController.addListener(() {
    final text = startDateController.text.trim();

    if (text.isNotEmpty) {
      try {
        final date = DateFormat('dd/MM/yyyy').parseStrict(text);

        // Validar si la fecha es anterior a hoy
        final today = DateTime.now();
        final currentDate = DateTime(today.year, today.month, today.day); // Solo fecha actual
        if (date.isBefore(currentDate)) {
          // Marcar la fecha como inválida si es anterior a hoy
          const invalidStartDate = StartDate.dirty(value: null);
          state = state.copyWith(
            startDate: invalidStartDate,
            isValid: Formz.validate([
              invalidStartDate,
              state.endDate,
              state.name,
              state.description,
              state.location,
            ]),
          );
          debugPrint('Error: Fecha de inicio del evento no puede ser anterior a hoy.');
          return;
        }

        // Crear y validar la nueva fecha de inicio del evento
        final newStartDate = StartDate.dirty(value: date);

        // Verificar y ajustar la fecha de fin si es necesario
        EndDate newEndDate;
        if (state.endDate.value == null || state.endDate.value!.isBefore(date)) {
          newEndDate = EndDate.dirty(startDate: date, value: date);
          endDateController.text = DateFormat('dd/MM/yyyy').format(date); // Actualizar texto del controlador
        } else {
          newEndDate = EndDate.dirty(startDate: date, value: state.endDate.value);
        }

        // Actualizar el estado
        state = state.copyWith(
          startDate: newStartDate,
          endDate: newEndDate,
          isValid: Formz.validate([
            newStartDate,
            newEndDate,
            state.name,
            state.description,
            state.location,
          ]),
        );
      } catch (e) {
        // Manejar errores de formato de fecha
        const invalidStartDate = StartDate.dirty(value: null);
        state = state.copyWith(
          startDate: invalidStartDate,
          isValid: Formz.validate([
            invalidStartDate,
            state.endDate,
            state.name,
            state.description,
            state.location,
          ]),
        );
        debugPrint('Error al analizar la fecha de inicio del evento: $text');
      }
    } else {
      // Si el campo está vacío, marcar como inválido
      const emptyStartDate = StartDate.dirty(value: null);
      state = state.copyWith(
        startDate: emptyStartDate,
        isValid: Formz.validate([
          emptyStartDate,
          state.endDate,
          state.name,
          state.description,
          state.location,
        ]),
      );
      debugPrint('Error: Campo de fecha de inicio del evento vacío.');
    }
  });


    endDateController.addListener(() {
      final text = endDateController.text;

      if (text.isNotEmpty) {
        try {
          final date = DateFormat('dd/MM/yyyy').parseStrict(text);

          if (state.startDate.value == null) {
            final invalidEndDate = const EndDate.dirty(value: null);
            state = state.copyWith(
              endDate: invalidEndDate,
              isValid: Formz.validate([
                state.startDate,
                invalidEndDate,
                state.name,
                state.description,
                state.location,
              ]),
            );
            debugPrint('Error: Fecha de inicio no válida.');
            return;
          }

          final newEndDate = EndDate.dirty(startDate: state.startDate.value, value: date);

          state = state.copyWith(
            endDate: newEndDate,
            isValid: Formz.validate([
              state.startDate,
              newEndDate,
              state.name,
              state.description,
              state.location,
            ]),
          );
          debugPrint(newEndDate.errorMessage); // Para depuración
        } catch (e) {
          final invalidEndDate = EndDate.dirty(startDate: state.startDate.value, value: null);
          state = state.copyWith(
            endDate: invalidEndDate,
            isValid: Formz.validate([
              state.startDate,
              invalidEndDate,
              state.name,
              state.description,
              state.location,
            ]),
          );
          debugPrint(invalidEndDate.errorMessage); // Mostrar mensaje
        }
      } else {
        final emptyEndDate = EndDate.dirty(startDate: state.startDate.value, value: null);
        state = state.copyWith(
          endDate: emptyEndDate,
          isValid: Formz.validate([
            state.startDate,
            emptyEndDate,
            state.name,
            state.description,
            state.location,
          ]),
        );
      }
});



    inscriptionStartDateController.addListener(() async {
  final text = inscriptionStartDateController.text.trim();

  if (text.isNotEmpty) {
    try {
      final date = DateFormat('dd/MM/yyyy').parseStrict(text);

      // Verificar si la fecha es anterior a hoy
      final today = DateTime.now();
      final currentDate = DateTime(today.year, today.month, today.day); // Solo fecha actual
      if (date.isBefore(currentDate)) {
        // Marcar la fecha como inválida si es anterior a hoy
        const invalidStartDate = InscriptionStartDate.dirty(value: null);
        state = state.copyWith(
          inscriptionStartDate: invalidStartDate,
          isValid: Formz.validate([
            state.name,
            state.description,
            state.startDate,
            state.endDate,
            state.location,
            invalidStartDate,
            state.inscriptionEndDate,
          ]),
        );
        debugPrint('Error: Fecha de inicio de inscripción no puede ser anterior a hoy.');
        return;
      }

      // Crear y validar la nueva fecha de inicio de inscripción
      final newStartDate = InscriptionStartDate.dirty(
        value: date,
        eventStartDate: state.startDate.value,
      );

      // Actualizar el estado con la nueva fecha validada
      state = state.copyWith(
        inscriptionStartDate: newStartDate,
        isValid: Formz.validate([
          state.name,
          state.description,
          state.startDate,
          state.endDate,
          state.location,
          newStartDate,
          state.inscriptionEndDate,
        ]),
      );
    } catch (e) {
      // Si el texto no es una fecha válida, manejar el error
      const invalidStartDate = InscriptionStartDate.dirty(value: null);
      state = state.copyWith(
        inscriptionStartDate: invalidStartDate,
        isValid: Formz.validate([
          state.name,
          state.description,
          state.startDate,
          state.endDate,
          state.location,
          invalidStartDate,
          state.inscriptionEndDate,
        ]),
      );
      debugPrint('Error al analizar la fecha de inicio de inscripción: $text');
    }
  } else {
    // Si el campo está vacío, marcar como inválido
    const emptyStartDate = InscriptionStartDate.dirty(value: null);
    state = state.copyWith(
      inscriptionStartDate: emptyStartDate,
      isValid: Formz.validate([
        state.name,
        state.description,
        state.startDate,
        state.endDate,
        state.location,
        emptyStartDate,
        state.inscriptionEndDate,
      ]),
    );
    debugPrint('Error: Campo de fecha de inicio de inscripción vacío.');
  }
});
    
    inscriptionEndDateController.addListener(() {
      final text = inscriptionEndDateController.text.trim();

      if (text.isNotEmpty) {
        try {
          final date = DateFormat('dd/MM/yyyy').parseStrict(text);

          // Verificar si la fecha de inicio de inscripción es válida
          if (state.inscriptionStartDate.value == null) {
            // Marcar la fecha de fin como inválida debido a que falta la fecha de inicio
            final invalidEndDate = const InscriptionEndDate.dirty(value: null);
            state = state.copyWith(
              inscriptionEndDate: invalidEndDate,
              isValid: Formz.validate([
                state.name,
                state.description,
                state.startDate,
                state.endDate,
                state.location,
                state.inscriptionStartDate,
                invalidEndDate,
              ]),
            );
            debugPrint('Error: Fecha de inicio de inscripción inválida.');
            return; // Salir para evitar comparar con una fecha inválida
          }

          // Crear y validar la nueva fecha de fin de inscripción
          final newEndDate = InscriptionEndDate.dirty(
            inscriptionStartDate: state.inscriptionStartDate.value,
            eventStartDate: state.startDate.value,
            value: date,
          );

          // Actualizar el estado con la nueva fecha validada
          state = state.copyWith(
            inscriptionEndDate: newEndDate,
            isValid: Formz.validate([
              state.name,
              state.description,
              state.startDate,
              state.endDate,
              state.location,
              state.inscriptionStartDate,
              newEndDate,
            ]),
          );
        } catch (e) {
          // Si el texto no es una fecha válida, manejar el error
          final invalidEndDate = const InscriptionEndDate.dirty(value: null);
          state = state.copyWith(
            inscriptionEndDate: invalidEndDate,
            isValid: Formz.validate([
              state.name,
              state.description,
              state.startDate,
              state.endDate,
              state.location,
              state.inscriptionStartDate,
              invalidEndDate,
            ]),
          );
          debugPrint('Error al analizar la fecha de fin de inscripción: $text');
        }
      } else {
        // Si el campo está vacío, marcar como inválido
        final emptyEndDate = const InscriptionEndDate.dirty(value: null);
        state = state.copyWith(
          inscriptionEndDate: emptyEndDate,
          isValid: Formz.validate([
            state.name,
            state.description,
            state.startDate,
            state.endDate,
            state.location,
            state.inscriptionStartDate,
            emptyEndDate,
          ]),
        );
      }
    });




  }
  
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController startTimeController = TextEditingController();
  final TextEditingController endTimeController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController headerImageController = TextEditingController();
  final TextEditingController inscriptionStartDateController = TextEditingController();
  final TextEditingController inscriptionEndDateController = TextEditingController();
  final TextEditingController inscriptionStartTimeController = TextEditingController();
  final TextEditingController inscriptionEndTimeController = TextEditingController();
  final TextEditingController eventCapacityController = TextEditingController();
  final TextEditingController eventCostController = TextEditingController();
  final TextEditingController dayTextController = TextEditingController();
  final TextEditingController additionalInfoController = TextEditingController(); 
  final TextEditingController contactNameController = TextEditingController(); 
  final TextEditingController contactPhoneController = TextEditingController(); 
  final TextEditingController contactEmailController = TextEditingController();
  final TextEditingController webpageController = TextEditingController(); 
  final TextEditingController instagramController = TextEditingController(); 
  final TextEditingController facebookController = TextEditingController(); 
  final TextEditingController youtubeController = TextEditingController(); 
  final TextEditingController linkedinController = TextEditingController(); 


  void onNameChanged(String name) {
    final newName = EventName.dirty(value: name);
    state = state.copyWith(
      name: newName,
      isValid: Formz.validate([
        newName, 
        state.description, 
        state.startDate, 
        state.endDate, 
        state.location
      ])
    );
    nameController.text = name;
  }

  void onDescriptionChanged(String description) {
    final newDescription = Description.dirty(value: description);
    state = state.copyWith(
      description: newDescription,
      isValid: Formz.validate([
        state.name, 
        newDescription, 
        state.startDate, 
        state.endDate, 
        state.location
      ])
    );

    
  }
  
  void onStartDateChanged(DateTime date) {
  // Crear instancia de nueva fecha de inicio
    final newStartDate = StartDate.dirty(value: date);

    // Verificar si endDate está vacío o inválido
    EndDate newEndDate;
    if (state.endDate.value == null || state.endDate.value!.isBefore(date)) {
      // Si endDate está vacío o menor que startDate, asignar automáticamente startDate
      newEndDate = EndDate.dirty(startDate: date, value: date);
      endDateController.text = formatDate(date); // Actualizar el controlador de endDate
    } else {
      // Si endDate es válido, mantenerlo y validarlo nuevamente con el nuevo startDate
      newEndDate = EndDate.dirty(startDate: date, value: state.endDate.value);
    }

    // Actualizar el estado
    state = state.copyWith(
      startDate: newStartDate,
      endDate: newEndDate,
      agenda: [
        AgendaDay(
          day: 'Día 1 (${formatDate(date)})',
          date: date,
          activities: [],
        ),
      ],
      isValid: Formz.validate([
        newStartDate,
        newEndDate,
        state.name,
        state.description,
        state.location,
      ]),
    );

    // Actualizar el texto del controlador
    startDateController.text = formatDate(date);
  }


  void onEndDateChanged(DateTime date) {
    // Crear instancia de la nueva fecha de fin
    final newEndDate = EndDate.dirty(startDate: state.startDate.value, value: date);

    // Validar si es inválida
    if (newEndDate.isNotValid) return;

    // Actualizar el estado y filtrar agenda
    state = state.copyWith(
      endDate: newEndDate,
      agenda: state.agenda
          .where((day) => day.date.isBefore(date) || day.date.isAtSameMomentAs(date))
          .toList(),
      isValid: Formz.validate([
        state.name,
        state.description,
        state.startDate,
        newEndDate,
        state.location
      ]),
    );

  // Actualizar el texto del controlador
  endDateController.text = formatDate(date);
}

  void onStartTimeChanged(TimeOfDay time) {
    state = state.copyWith(startTime: time);
    startTimeController.text = formatTimeWithAMPM(time); 
  }

  void onEndTimeChanged(TimeOfDay time) {
    state = state.copyWith(endTime: time);
    endTimeController.text = formatTimeWithAMPM(time); // Formatea y actualiza el texto del controlador
  }

  void onImageChanged(File image) {
    final newImage = HeaderImage.dirty(value: image);

    state = state.copyWith(
      headerImage: newImage,
      headerImageName: image.path.split('/').last, // Muestra el nombre de la imagen
      isValid: Formz.validate([
        state.name,
        state.description,
        state.startDate,
        state.endDate,
        state.location,
        newImage,
      ]),
    );
  }

  void onLocationChanged(String location){
    final newLocation = Location.dirty(value: location);
    state = state.copyWith(
    location: newLocation,
    isValid: Formz.validate([
      state.name, 
      state.description, 
      state.startDate, 
      state.endDate,
      newLocation,
    ]),
    );
    locationController.text = location;
  }

  void onDifferentTimePerDayChanged(bool value){
    state = state.copyWith(differentSchedulesPerDay: value);
  }

  void onInscriptionStartDateChanged(DateTime date) {
    final newInscriptionStartDate = InscriptionStartDate.dirty(
      value: date,
      eventStartDate: state.startDate.value,
    );

    final newInscriptionEndDate = InscriptionEndDate.dirty(
      inscriptionStartDate: date,
      eventStartDate: state.startDate.value,
      value: state.inscriptionEndDate.value,
    );

    state = state.copyWith(
      inscriptionStartDate: newInscriptionStartDate,
      inscriptionEndDate: newInscriptionEndDate,
      isValid: Formz.validate([
        newInscriptionStartDate,
        newInscriptionEndDate,
        state.capacity,
        state.inscriptionCost,
        state.paymentMethods
      ]),
    );

    inscriptionStartDateController.text = formatDate(date);
  }


  void onInscriptionEndDateChanged(DateTime date) {
    final newInscriptionEndDate = InscriptionEndDate.dirty(
      inscriptionStartDate: state.inscriptionStartDate.value,
      eventStartDate: state.startDate.value,
      value: date,
    );

    state = state.copyWith(
      inscriptionEndDate: newInscriptionEndDate,
      isValid: Formz.validate([
        state.inscriptionStartDate,
        newInscriptionEndDate,
        state.capacity,
        state.inscriptionCost,
        state.paymentMethods
      ]),
    );

    inscriptionEndDateController.text = formatDate(date);
  }


  void onInscriptionStartTimeChanged(TimeOfDay time) {
    state = state.copyWith(inscriptionStartTime: time);
    inscriptionStartTimeController.text = formatTimeWithAMPM(time);
  }

  void onInscriptionEndTimeChanged(TimeOfDay time) {
    state = state.copyWith(inscriptionEndTime: time);
    inscriptionEndTimeController.text = formatTimeWithAMPM(time);
  }

  void onEventPublicChanged(bool value) {
    state = state.copyWith(isPublic: value);
  }

  void onEventCapacityChanged(int capacity){
    final newVenueCapacity = VenueCapacity.dirty(value: capacity.toString());
    state = state.copyWith(
      capacity: newVenueCapacity,
      isValid: Formz.validate([
        state.inscriptionStartDate, 
        state.inscriptionEndDate,
        newVenueCapacity,
        state.inscriptionCost,
        state.paymentMethods
      ])
    );
  }

  // Métodos para actualizar los campos
  void onCostChanged(double inscriptionCost) {

    final newInscriptionCost= InscriptionCost.dirty(value: inscriptionCost.toString());
    state = state.copyWith(
      inscriptionCost: newInscriptionCost,
      isValid: Formz.validate([
        state.inscriptionStartDate, 
        state.inscriptionEndDate,
        state.capacity,
        newInscriptionCost,
        state.paymentMethods        
      ])
    );
  }

  void onPaymentMethodsChanged(MetodoPago method, bool value) {
    final currentMethods = List<String>.from(state.paymentMethods.value);
    final methodName = method.name;

    if (value) {
      currentMethods.add(methodName);
    } else {
      currentMethods.remove(methodName);
    }

    // Crear un nuevo estado de métodos de pago y validarlo
    final newPaymentMethods = PaymentMethods.dirty(value: currentMethods);

    state = state.copyWith(
      paymentMethods: newPaymentMethods,
      isValid: Formz.validate([
        state.inscriptionStartDate, // Otros campos del formulario
        state.inscriptionEndDate,
        state.capacity, // Validar capacidad
        state.inscriptionCost, // Validar costo de inscripción
        newPaymentMethods, // Validar métodos de pago
      ]),
    );
  }


  void addDay(String dayLabel, DateTime date) {
    // Validar si la fecha está dentro del rango permitido
    if (state.startDate.value != null && state.endDate.value != null) {
      if (date.isBefore(state.startDate.value!) || date.isAfter(state.endDate.value!)) {
        throw Exception('La fecha seleccionada está fuera del rango del evento.');
      }
    }

    // Verificar si el día ya existe
    if (state.agenda.any((day) => day.date == date)) {
      throw Exception('Este día ya existe en la agenda.');
    }

    // Agregar el nuevo día
    final newDay = AgendaDay(day: dayLabel, date: date, activities: []);
    state = state.copyWith(agenda: [...state.agenda, newDay]);

    // Reordenar los días para mantener la consistencia
    _updateDaysOrder();
  }


  /// Eliminar un día específico de la agenda
  void removeDay(String dia) {
    state = state.copyWith(
      agenda: state.agenda.where((day) => day.day != dia).toList(),
    );

    // Reordenar los días después de la eliminación
    _updateDaysOrder();
  }
  /// Actualizar el orden de los días y renombrarlos consecutivamente
  void _updateDaysOrder() {
    // Ordenar la lista por fecha
    final sortedAgenda = List<AgendaDay>.from(state.agenda)
      ..sort((a, b) => a.date.compareTo(b.date));

    // Renombrar los días en orden consecutivo
    for (int i = 0; i < sortedAgenda.length; i++) {
      sortedAgenda[i] = sortedAgenda[i].copyWith(
        day: 'Día ${i + 1} (${_formatDate(sortedAgenda[i].date)})',
      );
    }

    // Actualizar el estado con la lista ordenada y renombrada
    state = state.copyWith(agenda: sortedAgenda);
  }

  /// Formatear una fecha como "DD/MM/AAAA"
  String _formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }
  /// Método para agregar una actividad a un día específico
  void addActivity(String date, Activity activity) {
    final updatedAgenda = state.agenda.map((day) {
      if (day.day == date) {
        return day.copyWith(activities: [...day.activities, activity]);
      }
      return day;
    }).toList();
    state = state.copyWith(agenda: updatedAgenda);
  }

  void updateActivity(String date, Activity oldActivity, Activity newActivity) {
    final agenda = state.agenda.map((day) {
      if (day.day == date) {
        final updatedActivities = day.activities.map((activity) {
          return activity == oldActivity ? newActivity : activity;
        }).toList();
        return day.copyWith(activities: updatedActivities);
      }
      return day;
    }).toList();

    state = state.copyWith(agenda: agenda);
  }


void removeActivity(String dia, int index) {
  state = state.copyWith(
    agenda: state.agenda.map((day) {
      if (day.day == dia) {
        final actividades = List<Activity>.from(day.activities)..removeAt(index);
        return day.copyWith(activities: actividades);
      }
      return day;
    }).toList(),
  );
}

  void onAdditionalInfoChanged(String? additionalInfo) {
    final newAdditionalInfo = AdditionalInfo.dirty(value: additionalInfo ?? '');
    state = state.copyWith(
      additionalInfo: newAdditionalInfo,
      isValid: Formz.validate([newAdditionalInfo]),      
    );
  }

  void onAttachedDocumentsChanged(List<String>? value) {
    state = state.copyWith(attachedDcoment: value);
  }

  Future<void> pickFiles() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result != null && result.files.isNotEmpty) {
      // Agregamos los nuevos archivos al estado actual
      final currentFiles = List<String>.from(state.attachedDocument ?? []);
      final newFiles = result.files.map((file) => file.path!).toList();
      state = state.copyWith(attachedDcoment: [...currentFiles, ...newFiles]);
    }
  }

  void removeFile(int index) {
    // Verifica si hay archivos en el estado
    final currentFiles = List<String>.from(state.attachedDocument ?? []);
    if (index >= 0 && index < currentFiles.length) {
      currentFiles.removeAt(index);
      state = state.copyWith(attachedDcoment: currentFiles);
    }
  }

  void clearFiles() {
    // Limpia todos los archivos
    state = state.copyWith(attachedDcoment: []);
  }


 

  void onAgeRestrictionChanged(bool value) {
    state = state.copyWith(restriccionEdad: value);
  }

  void onContactNameChanged(String contactName) {
    final newContactName = CompanyName.dirty(value: contactName);
    state = state.copyWith(
      contactName: newContactName,
      isValid: Formz.validate([
        newContactName, 
        state.contactPhone, 
        state.contactEmail,
        ])
    );
  }

  void onContactPhoneChanged(String contactPhone) {
    final newContactPhone = Phone.dirty(value: contactPhone);
    state = state.copyWith(
      contactPhone: newContactPhone,
      isValid: Formz.validate([
        state.contactName, 
        newContactPhone, 
        state.contactEmail,
        ])
    );
  }

  void onContactEmailChanged(String contactEmail) {
    final newContactEmail = Email.dirty(value: contactEmail);
    state = state.copyWith(
      contactEmail: newContactEmail,
      isValid: Formz.validate([
        state.contactName, 
        state.contactPhone,
        newContactEmail, 
        ])
    );
  }

  void onWebpageChanged(String? webpage) {
  final newWebpage = SocialMedia.dirty(value: webpage ?? '');
    state = state.copyWith(
      webpage: newWebpage,
      isValid: Formz.validate([
        state.contactName, 
        state.contactPhone,
        state.contactEmail,
        ])
    );
  }

  void onInstagramChanged(String? instagram) {
    final newInstagram = SocialMedia.dirty(value: instagram ?? '');
    state = state.copyWith(
      instagram: newInstagram,
      isValid: Formz.validate([
        state.contactName, 
        state.contactPhone,
        state.contactEmail,
      ])
    );
  }

  void onFacebookChanged(String? facebook) {
    final newFacebook = SocialMedia.dirty(value: facebook ?? '');
    state = state.copyWith(
      facebook: newFacebook,
      isValid: Formz.validate([
        state.contactName, 
        state.contactPhone,
        state.contactEmail,
      ])
    );
  }

  void onYouTubeChanged(String? youtube) {
    final newYoutube = SocialMedia.dirty(value: youtube ?? '');
    state = state.copyWith(
      youtube: newYoutube,
      isValid: Formz.validate([
        state.contactName, 
        state.contactPhone,
        state.contactEmail,
      ])
    );
  }

  void onLinkedInChanged(String? linkedin) {
    final newLinkedin = SocialMedia.dirty(value: linkedin ?? '');
    state = state.copyWith(
      linkedin: newLinkedin,
      isValid: Formz.validate([
        state.contactName, 
        state.contactPhone,
        state.contactEmail,
      ])
    );
  }


  void onSubmitCreateEvent(){
    onSubmitEventInformation();
    if (!state.isEventInfoPosted) return;

    onSubmitEventInscription();
    if (!state.isEventIncriptionPosted) return;

    onSubmitEventAgenda();
    if (!state.isEventAgendaPosted) return;

    onSubmitEventContact();
    if (!state.isEventContactPosted) return;

    print('Evento creado exitosamente.');
    }


 
   void onSubmitEventInformation() {
    // Validar y actualizar campos
    _touchFieldsEventInformation();

    // Solo permite continuar si el formulario es válido
    if (!state.isValid) {
      print('Errores encontrados en la sección de Información del Evento.');
      return;
    }

    // Marcar como enviado
    state = state.copyWith(isEventInfoPosted: true);
    print('Información del evento validada correctamente.');
  }

  _touchFieldsEventInformation(){
    final name = EventName.dirty(value: state.name.value);
    final description = Description.dirty(value: state.description.value);
    final startDate = StartDate.dirty(value: state.startDate.value);
    final endDate = EndDate.dirty(startDate: state.startDate.value, value: state.endDate.value);
    final location = Location.dirty(value: state.location.value);
    final headerImage = HeaderImage.dirty(value: state.headerImage.value);

    state = state.copyWith(
      isEventInfoPosted: true,
      name: name,
      description: description,
      startDate: startDate,
      endDate: endDate,
      location: location,
      headerImage: headerImage,
      isValid: Formz.validate([name, description, startDate, endDate, location, headerImage])
    );
    if (headerImage.value != null) {
    print('HeaderImage Path: ${headerImage.value!.path}');
  } 
    print('Form isValid: ${state.isValid}');

  }


  void onSubmitEventInscription() {
    // Validar y actualizar campos
    _touchFieldsEventInscription();

    // Solo permite continuar si el formulario es válido
    if (!state.isValid) {
      print('Errores encontrados en la sección de Información del Evento.');
      return;
    }

    // Marcar como enviado
    state = state.copyWith(isEventIncriptionPosted: true);
    print('inscripcion del evento validada correctamente.');
  }



  _touchFieldsEventInscription(){
    final inscriptionStartDate = InscriptionStartDate.dirty(value: state.inscriptionStartDate.value);
    final inscriptionEndDate = InscriptionEndDate.dirty(value: state.inscriptionEndDate.value);
    final capacity = VenueCapacity.dirty(value: state.capacity.value);
    final inscriptionCost = InscriptionCost.dirty(value: state.inscriptionCost.value);
    final paymentMethods = PaymentMethods.dirty(value: state.paymentMethods.value);

    state = state.copyWith(
      isEventIncriptionPosted: true,
      inscriptionStartDate: inscriptionStartDate,
      inscriptionEndDate: inscriptionEndDate,
      capacity: capacity,
      inscriptionCost: inscriptionCost,
      paymentMethods: paymentMethods,
      isValid: Formz.validate([
        inscriptionStartDate, 
        inscriptionEndDate, 
        capacity, 
        inscriptionCost, 
        paymentMethods
      ])
    );  
  }

  
  void onSubmitEventAgenda() {
    // Validar y actualizar campos
    _touchFieldsEventAgenda();

    // Solo permite continuar si el formulario es válido
    if (!state.isValid) {
      print('Errores encontrados en la sección de Información del Evento.');
      return;
    }

    // Marcar como enviado
    state = state.copyWith(isEventAgendaPosted: true);
    print('Información de la agenda correctamente.');
  }

  _touchFieldsEventAgenda(){
    final List<AgendaDay> agenda = state.agenda;
    final additionalInfo = AdditionalInfo.dirty(value: state.additionalInfo?.value ?? '') ;
    final List<String>? attachedDocument = state.attachedDocument;

    state = state.copyWith(
      isEventAgendaPosted: true,
      agenda: agenda,
      additionalInfo: additionalInfo,
      attachedDcoment: attachedDocument,
      isValid: Formz.validate([additionalInfo])      
    ); 
  }

  void onSubmitEventContact() {
    // Validar y actualizar campos
    _touchFieldsEventContact();

    // Solo permite continuar si el formulario es válido
    if (!state.isValid) {
      print('Errores encontrados en la sección de Información del Evento.');
      return;
    }

    // Marcar como enviado
    state = state.copyWith(isEventContactPosted: true);
    print('Información de contacto correctamente.');
  }

  _touchFieldsEventContact(){
    final contactName = CompanyName.dirty(value: state.contactName.value);
    final contactEmail = Email.dirty(value: state.contactEmail.value);
    final contactPhone = Phone.dirty(value: state.contactPhone.value);
    final webpage = SocialMedia.dirty(value: state.webpage?.value ?? '');
    final instagram = SocialMedia.dirty(value: state.instagram?.value ?? '');
    final facebook = SocialMedia.dirty(value: state.facebook?.value ?? '');
    final youtube = SocialMedia.dirty(value: state.youtube?.value ?? '');
    final linkedin = SocialMedia.dirty(value: state.linkedin?.value ?? '');
    

    state = state.copyWith(
      isEventContactPosted: true,
      contactName: contactName,
      contactEmail: contactEmail,
      contactPhone: contactPhone,
      webpage: webpage,
      instagram: instagram,
      facebook: facebook,
      youtube: youtube,
      linkedin: linkedin,

      isValid: Formz.validate([
        contactName, 
        contactEmail, 
        contactPhone, 
        webpage,
        instagram,
        facebook,
        youtube,
        linkedin,
      ])      
    ); 
  }

  
}

class EventFormState {
  final bool isPosting;
  final bool isFormPosted;
  final bool isEventInfoPosted;
  final bool isEventIncriptionPosted;
  final bool isEventAgendaPosted;
  final bool isEventContactPosted;
  final bool isValid;
  final EventName name;
  final Description description;
  final StartDate startDate;
  final EndDate endDate;
  final TimeOfDay? startTime;
  final TimeOfDay? endTime;
  final bool? differentSchedulesPerDay;
  final Location location;
  final HeaderImage headerImage;
  final String? headerImageName;
  final String? headerImageError;
  final InscriptionStartDate inscriptionStartDate;
  final InscriptionEndDate inscriptionEndDate;
  final TimeOfDay? inscriptionStartTime;
  final TimeOfDay? inscriptionEndTime;
  final bool isPublic;
  final VenueCapacity capacity;
  final InscriptionCost inscriptionCost;
  final PaymentMethods paymentMethods;
  final List<AgendaDay> agenda;
  final AdditionalInfo? additionalInfo;
  final List<String>? attachedDocument;
  final bool restriccionEdad;
  final CompanyName contactName;
  final Phone contactPhone;
  final Email contactEmail;
  final SocialMedia? webpage;
  final SocialMedia? instagram;
  final SocialMedia? facebook;
  final SocialMedia? youtube;
  final SocialMedia? linkedin;


  EventFormState({
    this.isPosting = false,
    this.isFormPosted = false,
    this.isEventInfoPosted = false,
    this.isEventIncriptionPosted = false,
    this.isEventAgendaPosted = false,
    this.isEventContactPosted = false,
    this.isValid = false, 
    this.name = const EventName.pure(),
    this.description = const Description.pure(),
    this.startDate = const StartDate.pure(),
    this.endDate = const EndDate.pure(),
    this.startTime,
    this.endTime,
    this.differentSchedulesPerDay=false,
    this.location = const Location.pure(),
    this.headerImage = const HeaderImage.pure(),
    this.headerImageName,
    this.headerImageError,
    this.inscriptionStartDate = const InscriptionStartDate.pure(),
    this.inscriptionEndDate = const InscriptionEndDate.pure(),
    this.inscriptionStartTime,
    this.inscriptionEndTime,
    this.isPublic = true,
    this.capacity = const VenueCapacity.pure(),
    this.inscriptionCost = const InscriptionCost.pure(),
    this.paymentMethods = const PaymentMethods.pure(),
    this.agenda = const [],
    this.additionalInfo = const AdditionalInfo.pure(),
    this.attachedDocument,
    this.restriccionEdad = false,
    this.contactName = const CompanyName.pure(),
    this.contactPhone = const Phone.pure(),
    this.contactEmail = const Email.pure(),
    this.webpage = const SocialMedia.pure(), 
    this.instagram = const SocialMedia.pure(), 
    this.facebook = const SocialMedia.pure(), 
    this.youtube = const SocialMedia.pure(),
    this.linkedin = const SocialMedia.pure(),
  });

  EventFormState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isEventInfoPosted,
    bool? isEventIncriptionPosted,
    bool? isEventAgendaPosted,
    bool? isEventContactPosted,
    bool? isValid,
    EventName? name,
    Description? description,
    StartDate? startDate,
    EndDate? endDate,
    TimeOfDay? startTime,
    TimeOfDay? endTime,
    bool? differentSchedulesPerDay,
    Location? location,
    HeaderImage? headerImage,
    String? headerImageName,
    String? headerImageError,
    InscriptionStartDate? inscriptionStartDate,
    InscriptionEndDate? inscriptionEndDate,
    TimeOfDay? inscriptionStartTime,
    TimeOfDay? inscriptionEndTime,
    bool? isPublic,
    VenueCapacity? capacity,
    InscriptionCost? inscriptionCost,
    PaymentMethods? paymentMethods,
    List<AgendaDay>? agenda,
    AdditionalInfo? additionalInfo,
    List<String>? attachedDcoment,
    bool? restriccionEdad,
    CompanyName? contactName,
    Phone? contactPhone,
    Email? contactEmail,
    SocialMedia? webpage,
    SocialMedia? instagram,
    SocialMedia? facebook,
    SocialMedia? youtube,
    SocialMedia? linkedin, 
  }) => EventFormState(
    isPosting: isPosting ?? this.isPosting,
    isFormPosted: isFormPosted ?? this.isFormPosted,
    isEventInfoPosted: isEventInfoPosted ?? this.isEventInfoPosted,
    isEventIncriptionPosted: isEventIncriptionPosted ?? this.isEventIncriptionPosted,
    isEventAgendaPosted: isEventAgendaPosted ?? this.isEventAgendaPosted,
    isEventContactPosted: isEventContactPosted ?? this.isEventContactPosted,
    isValid: isValid ?? this.isValid,
    name: name ?? this.name,
    description: description ?? this.description,
    startDate: startDate ?? this.startDate,
    endDate: endDate ?? this.endDate,
    startTime: startTime ?? this.startTime,
    endTime: endTime ?? this.endTime,
    differentSchedulesPerDay: differentSchedulesPerDay ?? this.differentSchedulesPerDay,
    location: location ?? this.location,
    headerImage: headerImage ?? this.headerImage,
    headerImageName: headerImageName ?? this.headerImageName,
    headerImageError: headerImageError ?? this.headerImageError,
    inscriptionStartDate: inscriptionStartDate ?? this.inscriptionStartDate,
    inscriptionEndDate: inscriptionEndDate ?? this.inscriptionEndDate,
    inscriptionStartTime: inscriptionStartTime ?? this.inscriptionStartTime,
    inscriptionEndTime: inscriptionEndTime ?? this.inscriptionEndTime,
    isPublic: isPublic ?? this.isPublic,
    capacity: capacity ?? this.capacity,
    inscriptionCost: inscriptionCost ?? this.inscriptionCost,
    paymentMethods: paymentMethods ?? this.paymentMethods,
    agenda: agenda ?? this.agenda,
    additionalInfo: additionalInfo ?? this.additionalInfo,
    attachedDocument: attachedDcoment ?? this.attachedDocument,
    restriccionEdad: restriccionEdad ?? this.restriccionEdad,
    contactName: contactName ?? this.contactName,
    contactPhone: contactPhone ?? this.contactPhone,
    contactEmail: contactEmail ?? this.contactEmail,
    webpage: webpage ?? this.webpage,
    instagram:  instagram ?? this.instagram,
    facebook : facebook ?? this.facebook,
    youtube :youtube ?? this.youtube,
    linkedin : linkedin ?? this.linkedin,
  );
}


