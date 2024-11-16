import 'package:intl/intl.dart';

String formatDate(DateTime date) {
  final DateFormat formatter = DateFormat('dd/MM/yyyy'); // Formato deseado
  return formatter.format(date); // Convierte DateTime a String
}
