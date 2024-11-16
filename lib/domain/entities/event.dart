import 'package:flutter/material.dart';

class Event {
  // Detalles del Evento
  final String nombre; // Nombre oficial del evento
  final String descripcion; // Descripción breve del evento
  final DateTime fechaInicio; // Fecha de inicio del evento
  final DateTime fechaFin; // Fecha de fin del evento
  final TimeOfDay horaInicio; // Hora de inicio del evento
  final TimeOfDay horaFin; // Hora de fin del evento
  final bool horariosDiferentesPorDia; // Indica si cada día tiene un horario diferente
  final String ubicacion; // Dirección física o enlace de reunión virtual
  final String? imagenCabecera; // URL o ruta de la imagen de cabecera
  
  // Detalles de Inscripción
  final DateTime fechaInicioInscripcion; // Fecha de inicio de la inscripción
  final DateTime fechaFinInscripcion; // Fecha de fin de la inscripción
  final TimeOfDay horaInicioInscripcion; // Hora de inicio de la inscripción
  final TimeOfDay horaFinInscripcion; // Hora de fin de la inscripción
  final bool esPublico; // Indica si el evento es público o privado
  final int aforo; // Número máximo de asistentes
  final double costoInscripcion; // Costo de inscripción
  final List<String> metodosPago; // Métodos de pago aceptados
  
  // Agenda
  final List<DiaAgenda> agenda; // Lista de días y actividades programadas
  final String? informacionAdicional; // Información adicional (ej. comida, transporte)
  final List<String>? documentosAdjuntos; // Lista de documentos adjuntos
  
  // Restricciones
  final bool restriccionEdad; // Indica si hay restricción de edad
  
  // Información de Contacto
  final String nombreContacto; // Nombre de la persona de contacto
  final String telefonoContacto; // Teléfono de contacto
  final String emailContacto; // Correo electrónico de contacto

  Event({
    required this.nombre,
    required this.descripcion,
    required this.fechaInicio,
    required this.fechaFin,
    required this.horaInicio,
    required this.horaFin,
    required this.horariosDiferentesPorDia,
    required this.ubicacion,
    this.imagenCabecera,
    required this.fechaInicioInscripcion,
    required this.fechaFinInscripcion,
    required this.horaInicioInscripcion,
    required this.horaFinInscripcion,
    required this.esPublico,
    required this.aforo,
    required this.costoInscripcion,
    required this.metodosPago,
    required this.agenda,
    this.informacionAdicional,
    this.documentosAdjuntos,
    required this.restriccionEdad,
    required this.nombreContacto,
    required this.telefonoContacto,
    required this.emailContacto,
  });
}

class DiaAgenda {
  final String dia; // Día o fecha del evento
  final List<String> actividades; // Lista de actividades para el día

  DiaAgenda({
    required this.dia,
    required this.actividades,
  });
}
