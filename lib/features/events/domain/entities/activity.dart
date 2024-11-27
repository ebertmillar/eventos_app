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

  // Método para convertir la actividad en un Map
  Map<String, dynamic> toMap() {
    return {
      'startTime': startTime,
      'endTime': endTime,
      'description': description,
    };
  }

  // Método para crear una instancia de Activity desde un Map
  factory Activity.fromMap(Map<String, dynamic> map) {
    return Activity(
      startTime: map['startTime'] ?? '',
      endTime: map['endTime'] ?? '',
      description: map['description'] ?? '',
    );
  }
}

