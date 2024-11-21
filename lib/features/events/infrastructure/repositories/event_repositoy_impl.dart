

import 'package:eventos_app/features/events/domain/domain.dart';

class EventRepositoyImpl extends EventRepository{

  final EventDatasource datasource;

  EventRepositoyImpl(this.datasource);


  @override
  Future<Event> createUpdateEvent(Map<String, dynamic> eventLike) {
    return datasource.createUpdateEvent(eventLike);
  }

  @override
  Future<void> deleteEvent(String id) {
    return datasource.deleteEvent(id);
  }

  @override
  Future<Event> getEventById(String id) {
    return datasource.getEventById(id);
  }

  @override
  Future<List<Event>> getEventByPage({int limit = 10, int offset = 0}) {
    return datasource.getEventByPage(limit: limit, offset: offset) ;
  }


}



// class EventRepositoyImpl extends EventRepository {
//   @override
//   Future<Event> actualizarEvento(
//       String id,
//       String nombre,
//       String descripcion,
//       DateTime fechaInicio,
//       DateTime fechaFin,
//       TimeOfDay horaInicio,
//       TimeOfDay horaFin,
//       bool horariosDiferentesPorDia,
//       String ubicacion,
//       String? imagenCabecera,
//       DateTime fechaInicioInscripcion,
//       DateTime fechaFinInscripcion,
//       TimeOfDay horaInicioInscripcion,
//       TimeOfDay horaFinInscripcion,
//       bool esPublico,
//       int aforo,
//       double costoInscripcion,
//       List<String> metodosPago,
//       List<AgendaDay> agenda,
//       String? informacionAdicional,
//       List<String>? documentosAdjuntos,
//       bool restriccionEdad,
//       String nombreContacto,
//       String telefonoContacto,
//       String emailContacto) {
//     // TODO: implement actualizarEvento
//     throw UnimplementedError();
//   }

//   @override
//   Future<void> addDocumentToEvent(String eventId, String document) {
//     // TODO: implement addDocumentToEvent
//     throw UnimplementedError();
//   }

//   @override
//   Future<Event> crearEvento(
//       String nombre,
//       String descripcion,
//       DateTime fechaInicio,
//       DateTime fechaFin,
//       TimeOfDay horaInicio,
//       TimeOfDay horaFin,
//       bool horariosDiferentesPorDia,
//       String ubicacion,
//       String? imagenCabecera,
//       DateTime fechaInicioInscripcion,
//       DateTime fechaFinInscripcion,
//       TimeOfDay horaInicioInscripcion,
//       TimeOfDay horaFinInscripcion,
//       bool esPublico,
//       int aforo,
//       double costoInscripcion,
//       List<String> metodosPago,
//       List<AgendaDay> agenda,
//       String? informacionAdicional,
//       List<String>? documentosAdjuntos,
//       bool restriccionEdad,
//       String nombreContacto,
//       String telefonoContacto,
//       String emailContacto) {
//     // TODO: implement crearEvento
//     throw UnimplementedError();
//   }

//   @override
//   Future<void> eliminarEvento(String id) {
//     // TODO: implement eliminarEvento
//     throw UnimplementedError();
//   }

//   @override
//   Future<Event> obtenerEventoPorId(String id) {
//     // TODO: implement obtenerEventoPorId
//     throw UnimplementedError();
//   }

//   @override
//   Future<List<Event>> obtenerTodosLosEventos(bool? esPublico) {
//     // TODO: implement obtenerTodosLosEventos
//     throw UnimplementedError();
//   }

//   @override
//   Future<void> removeDocumentFromEvent(String eventId, String document) {
//     // TODO: implement removeDocumentFromEvent
//     throw UnimplementedError();
//   }
// }
