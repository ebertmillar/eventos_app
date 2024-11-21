import 'package:eventos_app/features/events/domain/entities/activity.dart';

class AgendaDay {
  final String day;
  final DateTime date; // Asegúrate de incluir este campo
  final List<Activity> activities;

  AgendaDay({
    required this.day,
    required this.date, // Asegúrate de inicializar 'fecha' aquí
    required this.activities,
  });

  AgendaDay copyWith({
    String? day,
    DateTime? date,
    List<Activity>? activities,
  }) {
    return AgendaDay(
      day: day ?? this.day,
      date: date ?? this.date, // Actualiza 'fecha' si es necesario
      activities: activities ?? this.activities,
    );
  }
}


