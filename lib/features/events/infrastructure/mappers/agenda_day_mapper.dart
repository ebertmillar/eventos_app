import 'package:eventos_app/features/events/domain/domain.dart';
import 'package:eventos_app/features/events/infrastructure/mappers/activity_mappers.dart';

class AgendaDayMapper {

  static AgendaDay jsonToEntity(Map<String, dynamic> json) {
    // Mapear solo los campos presentes en la respuesta del servidor
    return AgendaDay(
      day: json['day'],
      date: DateTime.parse(json['date']),
      activities: List<Activity>.from(
        json['activities'].map((activity) => ActivityMappers.jsonToEntity(activity)),
      ), 
    );
  }

}