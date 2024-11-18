import 'package:eventos_app/domain/entities/entities.dart';
import 'package:eventos_app/domain/repositories/event_repository.dart';
import 'package:flutter/material.dart';

class EventRepositoyImpl extends EventRepository {
  @override
  Future<Event> actualizarEvento(
      String id,
      String nombre,
      String descripcion,
      DateTime fechaInicio,
      DateTime fechaFin,
      TimeOfDay horaInicio,
      TimeOfDay horaFin,
      bool horariosDiferentesPorDia,
      String ubicacion,
      String? imagenCabecera,
      DateTime fechaInicioInscripcion,
      DateTime fechaFinInscripcion,
      TimeOfDay horaInicioInscripcion,
      TimeOfDay horaFinInscripcion,
      bool esPublico,
      int aforo,
      double costoInscripcion,
      List<String> metodosPago,
      List<AgendaDay> agenda,
      String? informacionAdicional,
      List<String>? documentosAdjuntos,
      bool restriccionEdad,
      String nombreContacto,
      String telefonoContacto,
      String emailContacto) {
    // TODO: implement actualizarEvento
    throw UnimplementedError();
  }

  @override
  Future<void> addDocumentToEvent(String eventId, String document) {
    // TODO: implement addDocumentToEvent
    throw UnimplementedError();
  }

  @override
  Future<Event> crearEvento(
      String nombre,
      String descripcion,
      DateTime fechaInicio,
      DateTime fechaFin,
      TimeOfDay horaInicio,
      TimeOfDay horaFin,
      bool horariosDiferentesPorDia,
      String ubicacion,
      String? imagenCabecera,
      DateTime fechaInicioInscripcion,
      DateTime fechaFinInscripcion,
      TimeOfDay horaInicioInscripcion,
      TimeOfDay horaFinInscripcion,
      bool esPublico,
      int aforo,
      double costoInscripcion,
      List<String> metodosPago,
      List<AgendaDay> agenda,
      String? informacionAdicional,
      List<String>? documentosAdjuntos,
      bool restriccionEdad,
      String nombreContacto,
      String telefonoContacto,
      String emailContacto) {
    // TODO: implement crearEvento
    throw UnimplementedError();
  }

  @override
  Future<void> eliminarEvento(String id) {
    // TODO: implement eliminarEvento
    throw UnimplementedError();
  }

  @override
  Future<Event> obtenerEventoPorId(String id) {
    // TODO: implement obtenerEventoPorId
    throw UnimplementedError();
  }

  @override
  Future<List<Event>> obtenerTodosLosEventos(bool? esPublico) {
    // TODO: implement obtenerTodosLosEventos
    throw UnimplementedError();
  }

  @override
  Future<void> removeDocumentFromEvent(String eventId, String document) {
    // TODO: implement removeDocumentFromEvent
    throw UnimplementedError();
  }
}
