
import 'dart:io';
import 'package:eventos_app/domain/entities/entities.dart';
import 'package:eventos_app/domain/enum/payment_method.dart';
import 'package:eventos_app/helpers/date_time_formatters.dart';
import 'package:eventos_app/helpers/form_date.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';


final createEventFormProvider = 
  StateNotifierProvider<CreateEventFormNotifier, EventFormState>((ref) {
    return CreateEventFormNotifier();
});


class CreateEventFormNotifier extends StateNotifier<EventFormState>{
  CreateEventFormNotifier() : super(EventFormState()){

    startDateController.addListener(() {
  final text = startDateController.text;

  // Validar el formato ingresado para evitar errores al agregar caracteres
  if (text.isNotEmpty) {
    try {
      // Intentar analizar la fecha solo si tiene un formato válido parcial
      final date = DateFormat('dd/MM/yyyy').parseStrict(text);
      if (state.startDate != date) {
        state = state.copyWith(
          startDate: date,
          agenda: [
              AgendaDay(
                day: 'Día 1 (${formatDate(date)})',
                date: date,
                activities: [],
              ),
            ],  
        );
      }
    } catch (e) {
      debugPrint('Formato de fecha no válido: $text');
    }
  }
});

endDateController.addListener(() {
  final text = endDateController.text;

  // Validar el formato ingresado para evitar errores al agregar caracteres
  if (text.isNotEmpty) {
    try {
      // Intentar analizar la fecha solo si tiene un formato válido parcial
      final date = DateFormat('dd/MM/yyyy').parseStrict(text);

      // Validar que la fecha de fin sea mayor o igual a la fecha de inicio
      if (state.startDate != null && date.isBefore(state.startDate!)) {
        throw Exception('La fecha de fin debe ser mayor o igual a la fecha de inicio.');
      }

      if (state.endDate != date) {
        state = state.copyWith(endDate: date);

        // Eliminar días de la agenda fuera del rango permitido
        state = state.copyWith(
          agenda: state.agenda
              .where((day) => day.date.isBefore(date) || day.date.isAtSameMomentAs(date))
              .toList(),
        );
      }
    } catch (e) {
      debugPrint('Formato de fecha no válido: $text');
    }
  }
});



    inscriptionEndDateController.addListener(() {
      final text = inscriptionEndDateController.text.trim();
        try {
          final date = DateFormat('dd/MM/yyyy').parse(text);
          state = state.copyWith(inscriptionEndDate: date); 
        } catch (e) {
          debugPrint('Error al analizar la fecha: $text');
        }
    });

    startTimeController.addListener(() {
      final text = startTimeController.text.trim();
      final time = parseTimeWithAMPM(text);
       if(time != null){
         state = state.copyWith(startTime: time);
       }      
    });
  
    endTimeController.addListener(() {
      final text = endTimeController.text.trim();
      final time = parseTimeWithAMPM(text); // Convierte el texto ingresado a TimeOfDay
      if (time != null) {
        state = state.copyWith(endTime: time);
      }
    });

    inscriptionStartDateController.addListener(() {
      final text = inscriptionStartDateController.text.trim();
      try {
        final date = DateFormat('dd/MM/yyyy').parse(text);
        state = state.copyWith(inscriptionStartDate: date);
      } catch (e) {
        debugPrint('Error al analizar la fecha de inicio de inscripción: $text');
      }
    });

    inscriptionEndDateController.addListener(() {
      final text = inscriptionEndDateController.text.trim();
      try {
        final date = DateFormat('dd/MM/yyyy').parse(text);
        state = state.copyWith(inscriptionEndDate: date);
      } catch (e) {
        debugPrint('Error al analizar la fecha de fin de inscripción: $text');
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
    state = state.copyWith(name: name);
    nameController.text = name;
  }

  void onDescriptionChanged(String description){
    state = state.copyWith(description: description);
    descriptionController.text = description;
  }
  
void onStartDateChanged(DateTime date) {
  // Actualizar solo la fecha de inicio
  state = state.copyWith(
    startDate: date,
    agenda: [
      AgendaDay(
        day: 'Día 1 (${formatDate(date)})',
        date: date,
        activities: [],
      ),
    ],
  );

  // Actualizar el texto del controlador
  startDateController.text = formatDate(date);
}

void onEndDateChanged(DateTime date) {
  // Validar que la fecha de fin no sea menor que la fecha de inicio
  if (state.startDate != null && date.isBefore(state.startDate!)) {
    throw Exception('La fecha de fin debe ser mayor o igual a la fecha de inicio.');
  }

  // Eliminar días de la agenda fuera del rango permitido
  state = state.copyWith(
    agenda: state.agenda
        .where((day) => day.date.isBefore(date) || day.date.isAtSameMomentAs(date))
        .toList(),
  );

  // Actualizar el estado con la nueva fecha de fin
  state = state.copyWith(endDate: date);

  // Sincronizar el controlador con el valor actualizado
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

  void onImageChanged(File newImage) {
    state = state.copyWith(
      headerImage: newImage,
      headerImageName: newImage.path.split('/').last, // Extrae el nombre del archivo de la ruta
    );
  }

  void onLocationChanged(String location){
    state = state.copyWith(location: location);
    locationController.text = location;
  }

  void onDifferentTimePerDayChanged(bool value){
    state = state.copyWith(differentSchedulesPerDay: value);
  }

  void onInscriptionStartDateChanged(DateTime date) {
    state = state.copyWith(inscriptionStartDate: date);
    inscriptionStartDateController.text = formatDate(date); // Actualiza el controlador
  }

  void onIncriptionEndDateChanged(DateTime date) {
    state = state.copyWith(inscriptionEndDate: date);
    inscriptionEndDateController.text = formatDate(date); // Actualiza el controlador
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

  void onEventCapacityChanged(int value){
    state = state.copyWith(capacity: value);
  }

  // Métodos para actualizar los campos
  void onCostChanged(double value) {
    state = state.copyWith(inscriptionCost: value);
  }

  void onPaymentMethodsChanged(MetodoPago method, bool value) {
    final paymentMethod = List<String>.from(state.paymentMethods);
    final stringMethod = method.name;

    if (value) {
        paymentMethod.add(stringMethod);
    } else {
        paymentMethod.remove(stringMethod);
    }

    state = state.copyWith(paymentMethods: paymentMethod);

  }


  void addDay(String dayLabel, DateTime date) {
    // Validar si la fecha está dentro del rango permitido
    if (state.startDate != null && state.endDate != null) {
      if (date.isBefore(state.startDate!) || date.isAfter(state.endDate!)) {
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

  void onAdditionalInfoChanged(String value) {
    state = state.copyWith(informacionAdicional: value);
  }

  void onAttachedDocumentsChanged(List<String> value) {
    state = state.copyWith(documentosAdjuntos: value);
  }

  Future<void> pickFiles() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result != null && result.files.isNotEmpty) {
      // Agregamos los nuevos archivos al estado actual
      final currentFiles = List<String>.from(state.documentosAdjuntos ?? []);
      final newFiles = result.files.map((file) => file.path!).toList();
      state = state.copyWith(documentosAdjuntos: [...currentFiles, ...newFiles]);
    }
  }

  void removeFile(int index) {
    // Verifica si hay archivos en el estado
    final currentFiles = List<String>.from(state.documentosAdjuntos ?? []);
    if (index >= 0 && index < currentFiles.length) {
      currentFiles.removeAt(index);
      state = state.copyWith(documentosAdjuntos: currentFiles);
    }
  }

  void clearFiles() {
    // Limpia todos los archivos
    state = state.copyWith(documentosAdjuntos: []);
  }


 

  void onAgeRestrictionChanged(bool value) {
    state = state.copyWith(restriccionEdad: value);
  }

  void onContactNameChanged(String value) {
    state = state.copyWith(nameContacto: value);
  }

  void onContactPhoneChanged(String value) {
    state = state.copyWith(telefonoContacto: value);
  }

  void onContactEmailChanged(String value) {
    state = state.copyWith(emailContacto: value);
  }

  void onWebpageChanged(String value) {
  state = state.copyWith(webpage: value);
  }

  void onInstagramChanged(String value) {
    state = state.copyWith(instagram: value);
  }

  void onFacebookChanged(String value) {
    state = state.copyWith(facebook: value);
  }

  void onYouTubeChanged(String value) {
    state = state.copyWith(youtube: value);
  }

  void onLinkedInChanged(String value) {
    state = state.copyWith(linkedin: value);
  }

}


class EventFormState {
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final String name;
  final String description;
  final DateTime? startDate;
  final DateTime? endDate;
  final TimeOfDay? startTime;
  final TimeOfDay? endTime;
  final bool? differentSchedulesPerDay;
  final String location;
  final File? headerImage;
  final String? headerImageName;
  final DateTime? inscriptionStartDate;
  final DateTime? inscriptionEndDate;
  final TimeOfDay? inscriptionStartTime;
  final TimeOfDay? inscriptionEndTime;
  final bool isPublic;
  final int capacity;
  final double inscriptionCost;
  final List<String> paymentMethods;
  final List<AgendaDay> agenda;
  final String? informacionAdicional;
  final List<String>? documentosAdjuntos;
  final bool restriccionEdad;
  final String nameContacto;
  final String telefonoContacto;
  final String emailContacto;
  final String? webpage;
  final String? instagram;
  final String? facebook;
  final String? youtube;
  final String? linkedin;


  EventFormState({
    this.isPosting = false,
    this.isFormPosted = false,
    this.isValid = false,
    this.name = '',
    this.description = '',
    this.startDate,
    this.endDate,
    this.startTime,
    this.endTime,
    this.differentSchedulesPerDay=false,
    this.location = '',
    this.headerImage,
    this.headerImageName,
    this.inscriptionStartDate,
    this.inscriptionEndDate,
    this.inscriptionStartTime,
    this.inscriptionEndTime,
    this.isPublic = true,
    this.capacity = 0,
    this.inscriptionCost = 0.0,
    this.paymentMethods = const [],
    this.agenda = const [],
    this.informacionAdicional,
    this.documentosAdjuntos,
    this.restriccionEdad = false,
    this.nameContacto = '',
    this.telefonoContacto = '',
    this.emailContacto = '',
    this.webpage = '', 
    this.instagram = '', 
    this.facebook = '', 
    this.youtube = '',
    this.linkedin = '',
  });

  EventFormState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    String? name,
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    TimeOfDay? startTime,
    TimeOfDay? endTime,
    bool? differentSchedulesPerDay,
    String? location,
    File? headerImage,
    String? headerImageName,
    DateTime? inscriptionStartDate,
    DateTime? inscriptionEndDate,
    TimeOfDay? inscriptionStartTime,
    TimeOfDay? inscriptionEndTime,
    bool? isPublic,
    int? capacity,
    double? inscriptionCost,
    List<String>? paymentMethods,
    List<AgendaDay>? agenda,
    String? informacionAdicional,
    List<String>? documentosAdjuntos,
    bool? restriccionEdad,
    String? nameContacto,
    String? telefonoContacto,
    String? emailContacto,
    String? webpage,
    String? instagram,
    String? facebook,
    String? youtube,
    String? linkedin,
  }) => EventFormState(
    isPosting: isPosting ?? this.isPosting,
    isFormPosted: isFormPosted ?? this.isFormPosted,
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
    inscriptionStartDate: inscriptionStartDate ?? this.inscriptionStartDate,
    inscriptionEndDate: inscriptionEndDate ?? this.inscriptionEndDate,
    inscriptionStartTime: inscriptionStartTime ?? this.inscriptionStartTime,
    inscriptionEndTime: inscriptionEndTime ?? this.inscriptionEndTime,
    isPublic: isPublic ?? this.isPublic,
    capacity: capacity ?? this.capacity,
    inscriptionCost: inscriptionCost ?? this.inscriptionCost,
    paymentMethods: paymentMethods ?? this.paymentMethods,
    agenda: agenda ?? this.agenda,
    informacionAdicional: informacionAdicional ?? this.informacionAdicional,
    documentosAdjuntos: documentosAdjuntos ?? this.documentosAdjuntos,
    restriccionEdad: restriccionEdad ?? this.restriccionEdad,
    nameContacto: nameContacto ?? this.nameContacto,
    telefonoContacto: telefonoContacto ?? this.telefonoContacto,
    emailContacto: emailContacto ?? this.emailContacto,
    webpage: webpage ?? this.webpage,
    instagram:  instagram ?? this.instagram,
    facebook : facebook ?? this.facebook,
    youtube :youtube ?? this.youtube,
    linkedin : linkedin ?? this.linkedin,
  );
}
