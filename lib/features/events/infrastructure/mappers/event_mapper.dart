import 'package:eventos_app/core/config/constants/environment.dart';
import 'package:eventos_app/features/events/domain/entities/agenda_day.dart';
import 'package:eventos_app/features/events/domain/entities/event.dart';
import 'package:eventos_app/features/events/infrastructure/mappers/agenda_day_mapper.dart';
import 'package:eventos_app/shared/helpers/parse_time_of_day.dart';

class EventMapper {

  static Event jsonToEntity(Map<String, dynamic> json) {
    // Mapear solo los campos presentes en la respuesta del servidor
    return Event(
      id: json["id"] ?? '',
      createdBy: json["createdBy"],
      name: json["name"],
      description: json["description"],
      startDate: DateTime.parse(json["startDate"]),
      endDate: DateTime.parse(json["endDate"]),
      startTime: parseTimeOfDay(json["startTime"]),
      endTime: parseTimeOfDay(json["endTime"]),
      differentSchedulesPerDay: json["differentSchedulesPerDay"] ?? false,
      location: json["location"] ?? '',
      headerImage: _rebuildImageUrl(json["headerImage"]),
      inscriptionStartDate: json["inscriptionStartDate"] != null 
        ? DateTime.parse(json["inscriptionStartDate"])
        : DateTime.now(),
      inscriptionEndDate: json["inscriptionEndDate"] != null 
        ? DateTime.parse(json["inscriptionEndDate"])
        : DateTime.parse(json["startDate"]),
      inscriptionStartTime: parseTimeOfDay(json["inscriptionStartTime"]),
      inscriptionEndTime: parseTimeOfDay(json["inscriptionEndTime"]),
      isPublic: json["isPublic"] ?? true,
      capacity: json["capacity"],
      inscriptionCost: double.parse(json["inscriptionCost"].toString()),
      paymentMethods: List<String>.from(json["paymentMethods"].map((x) => x)),
      agenda: json["agenda"] != null 
        ? List<AgendaDay>.from(json["agenda"].map((x) => AgendaDayMapper.jsonToEntity(x)))
        :[],
      additionalInformation: json["additionalInformation"],
      attachedDocuments: _rebuildDocumentUrls(json["createdBy"], json["attachedDocuments"]),
      ageRestriction: json["ageRestriction"] ?? false,
      contactName: json["contactName"],
      contactPhone: json["contactPhone"],
      contactEmail: json["contactEmail"],
      webpage: json["webpage"] ?? '',
      instagram: json["instagram"] ?? '',
      facebook: json["facebook"] ?? '',
      youtube: json["youtube"] ?? '',
      linkedin: json["linkedin"] ?? '',
      createdAt: DateTime.parse(json["createdAt"]),
    );
  }


  /// Reconstruye la URL completa de la imagen si es necesario.
  static String _rebuildImageUrl(String? imageName) {
    if (imageName == null || imageName.startsWith('http')) {
      return imageName ?? ''; // Devolver directamente si ya es una URL
    }
    return '${Environment.apiUrl}/api/files/event/header-image/$imageName';
  }

  static List<String> _rebuildDocumentUrls(String userId, List<String>? documents) {
  if (documents == null || userId.isEmpty) return [];

  return documents.map(
    (doc) => doc.startsWith('http')
        ? doc
        : '${Environment.apiUrl}/api/files/event/documents/user/$userId/$doc',
  ).toList();
}



}


