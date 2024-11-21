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
