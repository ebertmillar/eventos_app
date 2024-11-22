import 'package:intl/intl.dart';

String formatDate(DateTime date) {
  final DateFormat formatter = DateFormat('dd/MM/yyyy'); // Formato deseado
  return formatter.format(date); // Convierte DateTime a String
}

String formatDateRange(DateTime startDate, DateTime endDate) {
  final dateFormatter = DateFormat('dd/MM'); // Formato deseado
  final start = dateFormatter.format(startDate);
  final end = dateFormatter.format(endDate);

  return '$start - $end';
}
