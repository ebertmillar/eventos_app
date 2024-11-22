
import 'package:eventos_app/features/events/domain/entities/activity.dart';

class ActivityMappers {

  static Activity jsonToEntity(Map<String, dynamic> json) {
    // Mapear solo los campos presentes en la respuesta del servidor
    return Activity(
      startTime: json["startTime"] ?? '',
      endTime: json['endTime'] ?? '',
      description: json['description'] ?? '',     
    );
  }

}