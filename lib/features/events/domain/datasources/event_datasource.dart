


import 'package:eventos_app/features/events/domain/entities/event.dart';

abstract class EventsDatasource {

  Future<List<Event>> getEventByPage({ int limit = 10, int offset = 0});

  Future<Event> getEventById(String id);

  Future<Event> createUpdateEvent(Map<String,dynamic> eventLike);

  Future<void> deleteEvent(String id);

}



































// abstract class EventoDatasource {
//   /// Crea un nuevo evento
//   Future<Event> crearEvento(
//     String nombre,
//     String descripcion,
//     DateTime fechaInicio,
//     DateTime fechaFin,
//     TimeOfDay horaInicio,
//     TimeOfDay horaFin,
//     bool horariosDiferentesPorDia,
//     String ubicacion,
//     String? imagenCabecera,
//     DateTime fechaInicioInscripcion,
//     DateTime fechaFinInscripcion,
//     TimeOfDay horaInicioInscripcion,
//     TimeOfDay horaFinInscripcion,
//     bool esPublico,
//     int aforo,
//     double costoInscripcion,
//     List<String> metodosPago,
//     List<AgendaDay> agenda,
//     String? informacionAdicional,
//     List<String>? documentosAdjuntos,
//     bool restriccionEdad,
//     String nombreContacto,
//     String telefonoContacto,
//     String emailContacto,
//   );

//   /// Obtiene un evento por su ID
//   Future<Event> obtenerEventoPorId(String id);

//   /// Actualiza un evento existente
//   Future<Event> actualizarEvento(
//     String id,
//     String nombre,
//     String descripcion,
//     DateTime fechaInicio,
//     DateTime fechaFin,
//     TimeOfDay horaInicio,
//     TimeOfDay horaFin,
//     bool horariosDiferentesPorDia,
//     String ubicacion,
//     String? imagenCabecera,
//     DateTime fechaInicioInscripcion,
//     DateTime fechaFinInscripcion,
//     TimeOfDay horaInicioInscripcion,
//     TimeOfDay horaFinInscripcion,
//     bool esPublico,
//     int aforo,
//     double costoInscripcion,
//     List<String> metodosPago,
//     List<AgendaDay> agenda,
//     String? informacionAdicional,
//     List<String>? documentosAdjuntos,
//     bool restriccionEdad,
//     String nombreContacto,
//     String telefonoContacto,
//     String emailContacto,
//   );

//   /// Elimina un evento por su ID
//   Future<void> eliminarEvento(String id);

//   /// Obtiene todos los eventos, con opción de filtrar por eventos públicos o privados
//   Future<List<Event>> obtenerTodosLosEventos(bool? esPublico);

//   Future<void> addDocumentToEvent(String eventId, String document);

//   // Remove a document from an event
//   Future<void> removeDocumentFromEvent(String eventId, String document);

// }


