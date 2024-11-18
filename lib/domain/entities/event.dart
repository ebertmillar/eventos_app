import 'package:eventos_app/domain/entities/entities.dart';
import 'package:flutter/material.dart';

class Event {
  // Detalles del Evento
  final String name; // Nombre oficial del evento
  final String description; // Descripción breve del evento
  final DateTime startDate; // Fecha de inicio del evento
  final DateTime endDate; // Fecha de fin del evento
  final TimeOfDay startTime; // Hora de inicio del evento
  final TimeOfDay endTime; // Hora de fin del evento
  final bool differentSchedulesPerDay; // Indica si cada día tiene un horario diferente
  final String location; // Dirección física o enlace de reunión virtual
  final String? headerImage; // URL de la imagen de cabecera (opcional)
  
  // Detalles de Inscripción
  final DateTime inscriptionStartDate; // Fecha de inicio de la inscripción
  final DateTime inscriptionEndDate; // Fecha de fin de la inscripción
  final TimeOfDay inscriptionStartTime; // Hora de inicio de la inscripción
  final TimeOfDay inscriptionEndTime; // Hora de fin de la inscripción
  final bool isPublic; // Indica si el evento es público o privado
  final int capacity; // Número máximo de asistentes
  final double inscriptionCost; // Costo de inscripción
  final List<String> paymentMethods; // Métodos de pago aceptados
  
  // Agenda
  final List<AgendaDay> agenda; // Lista de días y actividades programadas
  final String additionalInformation; // Información adicional (ej. comida, transporte)
  final List<String> attachedDocuments; // Lista de documentos adjuntos
  
  // Restricciones
  final bool ageRestriction; // Indica si hay restricción de edad
  
  // Información de Contacto
  final String contactName; // Nombre de la persona de contacto
  final String contactPhone; // Teléfono de contacto
  final String contactEmail; // Correo electrónico de contacto
  
  // Redes Sociales
  final String? webpage; // Página web oficial del evento
  final String? instagram; // Instagram del evento
  final String? facebook; // Facebook del evento
  final String? youtube; // YouTube del evento
  final String? linkedin; // LinkedIn del evento

  Event({
    required this.name,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.startTime,
    required this.endTime,
    required this.differentSchedulesPerDay,
    required this.location,
    this.headerImage, // Opcional
    required this.inscriptionStartDate,
    required this.inscriptionEndDate,
    required this.inscriptionStartTime,
    required this.inscriptionEndTime,
    required this.isPublic,
    required this.capacity,
    required this.inscriptionCost,
    required this.paymentMethods,
    required this.agenda,
    this.additionalInformation = '', // Valor predeterminado para evitar nulos
    this.attachedDocuments = const [], // Lista vacía por defecto
    required this.ageRestriction,
    required this.contactName,
    required this.contactPhone,
    required this.contactEmail,
    this.webpage,
    this.instagram,
    this.facebook,
    this.youtube,
    this.linkedin,
  });

}

