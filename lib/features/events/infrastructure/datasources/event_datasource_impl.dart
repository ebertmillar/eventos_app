
import 'package:dio/dio.dart';
import 'package:eventos_app/core/config/config.dart';
import 'package:eventos_app/features/events/domain/domian.dart';
import 'package:eventos_app/features/events/domain/errors/events_errors.dart';
import 'package:eventos_app/features/events/infrastructure/mappers/event_mapper.dart';

class EventDatasourceImpl extends EventsDatasource {

  late final Dio dio;
  final String? userId;
  final String accessToken;

  EventDatasourceImpl({
    this.userId,
    required this.accessToken,
  }): dio = Dio(
    BaseOptions(
      baseUrl: Environment.apiUrl,
      headers: {
        'Authorization': 'Bearer $accessToken'
      }
    ));

  Future<String> _uploadFilephoto (String path) async{

    try {
      
      final data = _buildFormData(path, 'image');
      final response = await dio.post('/api/files/event/header-image', data: data );
      return response.data['image'];

    } catch (e) {
      throw Exception();
    }
  }

  Future<String> _uploadPhoto(String photo) async {
    // Verificar si es una URL remota
    if (photo.startsWith('http://') || photo.startsWith('https://')) {
      return photo; // Es una URL, no subir
    }

    final String uploadedPhotoUrl = await _uploadFilephoto(photo);
    return uploadedPhotoUrl;
  }

  Future<List<String>> _uploadFileDocuments(String path) async {
    try {
      final data = _buildFormData(path, 'files');
      final response = await dio.post('/api/files/event/documents/$userId', data: data);
      return List<String>.from(response.data['files']); // Asegurarte de convertir correctamente
    } catch (e) {
      throw Exception('Error uploading documents: $e');
    }
  }


  Future<List<String>> _uploadDocuments(List<String> documents) async {
    // Filtrar documentos que ya son URLs y no necesitan subirse
    final documentsToIgnore = documents.where((doc) => doc.startsWith('http://') || doc.startsWith('https://')).toList();
    // Filtrar documentos que necesitan ser subidos
    final documentsToUpload = documents.where((doc) => !doc.startsWith('http://') && !doc.startsWith('https://')).toList();

    if (documentsToUpload.isEmpty) {
      // Si no hay nada que subir, devolver solo los documentos ignorados
      return documentsToIgnore;
    }

    try {
      // Subir documentos de forma paralela
      final List<Future<List<String>>> uploadJobs = documentsToUpload.map(_uploadFileDocuments).toList();

      // Esperar todas las subidas y aplanar la lista
      final List<List<String>> uploadedDocs = await Future.wait(uploadJobs);

      // Convertir la lista de listas en una lista plana
      final newDocuments = uploadedDocs.expand((docs) => docs).toList();

      // Combinar los documentos ignorados con los recién subidos
      return [...documentsToIgnore, ...newDocuments];
    } catch (e) {
      throw Exception('Error uploading documents: $e');
    }
  }

  Future<void> deleteDocument(String userId, String fileName) async {
  try {
    final response = await dio.delete('/api/files/event/documents/$userId/$fileName');
    if (response.statusCode != 200) {
      throw Exception("Error al eliminar el archivo: ${response.data['error']}");
    }
  } catch (e) {
    throw Exception("Error al intentar eliminar el archivo: $e");
  }
}




  @override
  Future<Event> createUpdateEvent(Map<String, dynamic> eventLike) async {
    
    try {

      final String? eventId = eventLike['id'];
      final String method = ( eventId == null) ? 'POST' : 'PATCH';
      final String url = (eventId == null) ?'/api/create-events' :'/api/update-event/$eventId';
      eventLike.remove('id');
      eventLike['headerImage'] = await _uploadPhoto(eventLike['headerImage']);
      eventLike['attachedDocuments'] = await _uploadDocuments( eventLike['attachedDocuments'] );

      final response = await dio.request(
        url,
        data: eventLike,
        options: Options(
          method: method,
        ),
      );

      print(response.data);
      final event = EventMapper.jsonToEntity(response.data);
      return event;
      
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteEvent(String id) {
    // TODO: implement deleteEvent
    throw UnimplementedError();
  }

  @override
  Future<Event> getEventById(String id) async {
    try {
      
      final response = await dio.get('/api/events/$id');
      final event = EventMapper.jsonToEntity(response.data);
      return event;

    } on DioException catch (dioError) {
      // Manejar errores específicos de Dio
      if (dioError.type == DioExceptionType.connectionTimeout) {
        throw ConnectionTimeout();
      } else if (dioError.type == DioExceptionType.receiveTimeout) {
        throw ConnectionTimeout('Tiempo de espera agotado al recibir datos');
      } else if (dioError.type == DioExceptionType.badResponse) {
        final statusCode = dioError.response?.statusCode;
        if (statusCode == 401) {
          throw UnauthorizedAccess();
        } else if (statusCode == 404) {
          throw EventNotFound();
        } else if (statusCode == 400) {
          throw BadRequest();
        } else {
          throw ServerError('Error en la respuesta del servidor: Código $statusCode');
        }
      } else {
        throw UnknownError('Error de red desconocido: ${dioError.message}');
      }
    } catch (e) {
      throw UnknownError('Ocurrió un error inesperado: $e');
    }
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


  FormData _buildFormData(String path, String key) {
    final fileName = path.split('/').last;
    return FormData.fromMap({
      key: MultipartFile.fromFileSync(path, filename: fileName),
    });
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
