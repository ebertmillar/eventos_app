import 'package:intl/intl.dart';

String formatDate(DateTime date) {
  final DateFormat formatter = DateFormat('dd/MM/yyyy'); // Formato deseado
  return formatter.format(date); // Convierte DateTime a String
}

String? formatDateUpdate(DateTime? date) {
  if (date == null) return null; // Manejo de valores nulos
  return DateFormat('dd/MM/yyyy').format(date); // Formato deseado
}

// Formato: Solo día (dd)
String formatDay(String dateString) {
  // Define el formato en el que esperas recibir la fecha
  final DateFormat inputFormat = DateFormat('dd/MM/yyyy');
  final DateTime date = inputFormat.parse(dateString); // Convierte el String a DateTime
  final DateFormat outputFormat = DateFormat('dd'); // Formato de salida
  return outputFormat.format(date); // Devuelve solo el día
}

// Formato: Día y mes (dd/MM)
String formatDayMonth(DateTime date) {
  final DateFormat formatter = DateFormat('dd/MM');
  return formatter.format(date);
}

// Formato: Día, mes y año (dd/MM/yyyy)
String formatFullDate(DateTime date) {
  final DateFormat formatter = DateFormat('dd/MM/yyyy');
  return formatter.format(date);
}

String formatDateRange(DateTime startDate, DateTime endDate) {
  final dateFormatter = DateFormat('dd/MM/yyyy'); // Formato deseado
  final start = dateFormatter.format(startDate);
  final end = dateFormatter.format(endDate);

  return '$start - $end';
}
