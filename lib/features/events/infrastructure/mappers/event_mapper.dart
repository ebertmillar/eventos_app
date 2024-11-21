import 'package:eventos_app/features/events/domain/domain.dart';
import 'package:eventos_app/features/events/infrastructure/mappers/agenda_day_mapper.dart';

class EventMapper {

  static Event jsonToEntity(Map<String, dynamic> json) {
    // Mapear solo los campos presentes en la respuesta del servidor
    return Event(
      id: json["id"],
      createdBy: json["createdBy"],
      name: json["name"],
      description: json["description"],
      startDate: DateTime.parse(json["startDate"]),
      endDate: DateTime.parse(json["endDate"]),
      startTime: json["startTime"],
      endTime: json["endTime"],
      differentSchedulesPerDay: json["differentSchedulesPerDay"] ?? false,
      location: json["location"],
      headerImage: json["headerImage"] ?? '',
      inscriptionStartDate: DateTime.parse(json["inscriptionStartDate"]),
      inscriptionEndDate: DateTime.parse(json["inscriptionEndDate"]),
      inscriptionStartTime: json["inscriptionStartTime"],
      inscriptionEndTime: json["inscriptionEndTime"],
      isPublic: json["isPublic"] ?? true,
      capacity: json["capacity"],
      inscriptionCost: double.parse(json["inscriptionCost"].toString()),
      paymentMethods: List<String>.from(json["paymentMethods"].map((x) => x)),
      agenda: json["agenda"] != null 
        ? List<AgendaDay>.from(json["agenda"].map((x) => AgendaDayMapper.jsonToEntity(x)))
        :[],
      additionalInformation: json["additionalInformation"],
      attachedDocuments: json["attachedDocuments"] != null 
        ? List<String>.from(json["attachedDocuments"].map((x) => x))
        :[],
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


}


