
import 'dart:io';

import 'package:eventos_app/domain/entities/event.dart';
import 'package:eventos_app/domain/enum/payment_method.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final createEventFormProvider = 
  StateNotifierProvider.autoDispose<CreateEventFormNotifier, EventFormState>((ref) {
    return CreateEventFormNotifier();
});

class CreateEventFormNotifier extends StateNotifier<EventFormState>{
  CreateEventFormNotifier() : super(EventFormState());

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController startTimeController = TextEditingController();
  final TextEditingController endTimeController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController headerImageController = TextEditingController();

  void onNameChanged(String name) {
    state = state.copyWith(name: name);
    nameController.text = name;
  }

  void onDescriptionChanged(String description){
    state = state.copyWith(descripcion: description);
    descriptionController.text = description;
  }
  
  void onStartDateChanged(DateTime date) {
    state = state.copyWith(fechaInicio: date);
    startDateController.text = "${date.day}/${date.month}/${date.year}";
  }

  void onEndDateChanged(DateTime date) {
    state = state.copyWith(fechaFin: date);
    endDateController.text = "${date.day}/${date.month}/${date.year}";
  }

  void onStartTimeChanged(TimeOfDay value) {
    state = state.copyWith(horaInicio: value);
    print(state.horaInicio);
  }

  void onEndTimeChanged(TimeOfDay value) {
    state = state.copyWith(horaFin: value);
  }

  void onImageChanged(File newImage) {
    state = state.copyWith(
      headerImage: newImage,
      headerImageName: newImage.path.split('/').last, // Extrae el nombre del archivo de la ruta
    );
  }

  void onLocationChanged(String location){
    state = state.copyWith(ubicacion: location);
    locationController.text = location;
  }

  void onDifferentTimePerDayChanged(bool value){
    state = state.copyWith(horariosDiferentesPorDia: value);
  }

  void onInscriptionStartDateChanged(DateTime value) {
    state = state.copyWith(fechaInicioInscripcion: value);
  }

  void onIncriptionEndDateChanged(DateTime value) {
    state = state.copyWith(fechaFinInscripcion: value);
  }

  void onInscriptionStartTimeChanged(TimeOfDay value) {
    state = state.copyWith(horaInicioInscripcion: value);
  }

  void onInscriptionEndTimeChanged(TimeOfDay value) {
    state = state.copyWith(horaFinInscripcion: value);
  }

  void onEventPublicChanged(bool value) {
    state = state.copyWith(esPublico: value);
  }

  void onEventCapacityChanged(int value){
    state = state.copyWith(aforo: value);
  }

  // Métodos para actualizar los campos
  void onCostChanged(double value) {
    state = state.copyWith(costoInscripcion: value);
  }

  void onPaymentMethodsChanged(MetodoPago metodo, bool value) {
    final paymentMethod = List<String>.from(state.metodosPago);
    final stringMethod = metodo.name;

    if (value) {
        paymentMethod.add(stringMethod);
    } else {
        paymentMethod.remove(stringMethod);
    }

    state = state.copyWith(metodosPago: paymentMethod);

  }

  void onAgendaChanged(List<DiaAgenda> value) {
    state = state.copyWith(agenda: value);
  }

  void onAdditionalInfoChanged(String value) {
    state = state.copyWith(informacionAdicional: value);
  }

  void onAttachedDocumentsChanged(List<String> value) {
    state = state.copyWith(documentosAdjuntos: value);
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

}



class EventFormState {
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final String name;
  final String descripcion;
  final DateTime? fechaInicio;
  final DateTime? fechaFin;
  final TimeOfDay? horaInicio;
  final TimeOfDay? horaFin;
  final bool? horariosDiferentesPorDia;
  final String ubicacion;
  final File? headerImage;
  final String? headerImageName;
  final DateTime? fechaInicioInscripcion;
  final DateTime? fechaFinInscripcion;
  final TimeOfDay? horaInicioInscripcion;
  final TimeOfDay? horaFinInscripcion;
  final bool esPublico;
  final int aforo;
  final double costoInscripcion;
  final List<String> metodosPago;
  final List<DiaAgenda> agenda;
  final String? informacionAdicional;
  final List<String>? documentosAdjuntos;
  final bool restriccionEdad;
  final String nameContacto;
  final String telefonoContacto;
  final String emailContacto;

  EventFormState({
    this.isPosting = false,
    this.isFormPosted = false,
    this.isValid = false,
    this.name = '',
    this.descripcion = '',
    this.fechaInicio,
    this.fechaFin,
    this.horaInicio,
    this.horaFin,
    this.horariosDiferentesPorDia=false,
    this.ubicacion = '',
    this.headerImage,
    this.headerImageName,
    this.fechaInicioInscripcion,
    this.fechaFinInscripcion,
    this.horaInicioInscripcion,
    this.horaFinInscripcion,
    this.esPublico = true,
    this.aforo = 0,
    this.costoInscripcion = 0.0,
    this.metodosPago = const [],
    this.agenda = const [],
    this.informacionAdicional,
    this.documentosAdjuntos,
    this.restriccionEdad = false,
    this.nameContacto = '',
    this.telefonoContacto = '',
    this.emailContacto = '',
  });

  EventFormState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    String? name,
    String? descripcion,
    DateTime? fechaInicio,
    DateTime? fechaFin,
    TimeOfDay? horaInicio,
    TimeOfDay? horaFin,
    bool? horariosDiferentesPorDia,
    String? ubicacion,
    File? headerImage,
    String? headerImageName,
    DateTime? fechaInicioInscripcion,
    DateTime? fechaFinInscripcion,
    TimeOfDay? horaInicioInscripcion,
    TimeOfDay? horaFinInscripcion,
    bool? esPublico,
    int? aforo,
    double? costoInscripcion,
    List<String>? metodosPago,
    List<DiaAgenda>? agenda,
    String? informacionAdicional,
    List<String>? documentosAdjuntos,
    bool? restriccionEdad,
    String? nameContacto,
    String? telefonoContacto,
    String? emailContacto,
  }) => EventFormState(
    isPosting: isPosting ?? this.isPosting,
    isFormPosted: isFormPosted ?? this.isFormPosted,
    isValid: isValid ?? this.isValid,
    name: name ?? this.name,
    descripcion: descripcion ?? this.descripcion,
    fechaInicio: fechaInicio ?? this.fechaInicio,
    fechaFin: fechaFin ?? this.fechaFin,
    horaInicio: horaInicio ?? this.horaInicio,
    horaFin: horaFin ?? this.horaFin,
    horariosDiferentesPorDia: horariosDiferentesPorDia ?? this.horariosDiferentesPorDia,
    ubicacion: ubicacion ?? this.ubicacion,
    headerImage: headerImage ?? this.headerImage,
    headerImageName: headerImageName ?? this.headerImageName,
    fechaInicioInscripcion: fechaInicioInscripcion ?? this.fechaInicioInscripcion,
    fechaFinInscripcion: fechaFinInscripcion ?? this.fechaFinInscripcion,
    horaInicioInscripcion: horaInicioInscripcion ?? this.horaInicioInscripcion,
    horaFinInscripcion: horaFinInscripcion ?? this.horaFinInscripcion,
    esPublico: esPublico ?? this.esPublico,
    aforo: aforo ?? this.aforo,
    costoInscripcion: costoInscripcion ?? this.costoInscripcion,
    metodosPago: metodosPago ?? this.metodosPago,
    agenda: agenda ?? this.agenda,
    informacionAdicional: informacionAdicional ?? this.informacionAdicional,
    documentosAdjuntos: documentosAdjuntos ?? this.documentosAdjuntos,
    restriccionEdad: restriccionEdad ?? this.restriccionEdad,
    nameContacto: nameContacto ?? this.nameContacto,
    telefonoContacto: telefonoContacto ?? this.telefonoContacto,
    emailContacto: emailContacto ?? this.emailContacto,
  );
}
