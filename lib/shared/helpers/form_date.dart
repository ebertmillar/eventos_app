import 'package:intl/intl.dart';

String formatDate(DateTime date) {
  final DateFormat formatter = DateFormat('dd/MM/yyyy'); // Formato deseado
  return formatter.format(date); // Convierte DateTime a String
}

String? formatDateUpdate(DateTime? date) {
  if (date == null) return null; // Manejo de valores nulos
  return DateFormat('dd/MM/yyyy').format(date); // Formato deseado
}

String formatDay(String input) {
  final regex = RegExp(r'\((.*?)\)'); // Encuentra el texto dentro de paréntesis
  final match = regex.firstMatch(input);

  if (match != null) {
    final datePart = match.group(1); // Extrae "05/12/2024"
    return datePart ?? input; // Retorna la fecha o el texto completo si no es válida
  }
  return input; // Retorna el texto sin cambios si no coincide
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
