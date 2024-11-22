
import 'package:dio/dio.dart';
import 'package:eventos_app/core/config/config.dart';
import 'package:eventos_app/features/events/domain/domian.dart';
import 'package:eventos_app/features/events/infrastructure/mappers/event_mapper.dart';

class EventDatasourceImpl extends EventDatasource {

  late final Dio dio;
  final String accessToken;

  EventDatasourceImpl({
    required this.accessToken
  }): dio = Dio(
    BaseOptions(
      baseUrl: Environment.apiUrl,
      headers: {
        'Authorization': 'Bearer $accessToken'
      }
    ));


  @override
  Future<Event> createUpdateEvent(Map<String, dynamic> eventLike) {
    // TODO: implement createUpdateEvent
    throw UnimplementedError();
  }

  @override
  Future<void> deleteEvent(String id) {
    // TODO: implement deleteEvent
    throw UnimplementedError();
  }

  @override
  Future<Event> getEventById(String id) {
    // TODO: implement getEventById
    throw UnimplementedError();
  }

  @override
  Future<List<Event>> getEventByPage({int limit = 10, int offset = 0}) async {
    final response = await dio.get<List>('/api/events?limit=$limit&offset=$offset');
    final List<Event> events = [];
    for (final event in response.data ?? [] ){
      events.add(EventMapper.jsonToEntity(event));
    }

    return events;
    
  }
}






// class EventDatasourceImpl extends EventoDatasource {
//   @override
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
//     String emailContacto) {
//   // TODO: implement actualizarEvento
//     throw UnimplementedError();
//   }

//   @override
//   Future<void> addDocumentToEvent(String eventId, String document) {
//     // TODO: implement addDocumentToEvent
//     throw UnimplementedError();
//   }

//   @override
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
//     String emailContacto) {
//   // TODO: implement crearEvento
//       throw UnimplementedError();
    
    
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
