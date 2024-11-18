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


class Activity {
  final String startTime; // Hora de inicio de la actividad
  final String endTime; // Hora de fin de la actividad
  final String description; // 
  
  Activity({
    required this.startTime,
    required this.endTime,
    required this.description,
  });

  Activity copyWith({
    String? startTime,
    String? endTime,
    String? description,
  }) {
    return Activity(
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      description: description ?? this.description,
    );
  }
}

