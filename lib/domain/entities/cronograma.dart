// Modelo de datos
class EventDay {
  final String date;
  final List<Activity> activities;

  EventDay({required this.date, required this.activities});
}

class Activity {
  final String startTime;
  final String endTime;
  final String title;

  Activity({
    required this.startTime,
    required this.endTime,
    required this.title,
  });
}