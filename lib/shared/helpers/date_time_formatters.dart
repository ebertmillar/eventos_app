import 'package:flutter/material.dart';

/// Formatea una hora (TimeOfDay) al formato de 12 horas con AM/PM
String formatTimeWithAMPM(TimeOfDay time) {
  final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod; // 12-hour format
  final minute = time.minute.toString().padLeft(2, '0');
  final period = time.period == DayPeriod.am ? 'AM' : 'PM';
  return '$hour:$minute $period';
}

TimeOfDay? parseTimeWithAMPM(String input) {
  try {
    final regex = RegExp(r'^(\d{1,2}):(\d{2})\s*(AM|PM)$', caseSensitive: false);
    final match = regex.firstMatch(input.trim());
    if (match != null) {
      final hour = int.parse(match.group(1)!);
      final minute = int.parse(match.group(2)!);
      final period = match.group(3)!.toUpperCase();

      if (hour < 1 || hour > 12 || minute < 0 || minute >= 60) {
        return null; // Hora no válida
      }

      final isPM = period == 'PM';
      final adjustedHour = isPM
          ? (hour == 12 ? 12 : hour + 12) // PM y no es 12 -> suma 12
          : (hour == 12 ? 0 : hour); // AM y es 12 -> ajusta a 0

      return TimeOfDay(hour: adjustedHour, minute: minute);
    }
  } catch (_) {
    return null;
  }
  return null; // Retorna null si no es válido
}

String? formatTimeOfDay(TimeOfDay? time) {
  if (time == null) {
    return null; // Manejar el caso nulo
  }
  final hours = time.hour.toString().padLeft(2, '0'); // Asegurar dos dígitos
  final minutes = time.minute.toString().padLeft(2, '0'); // Asegurar dos dígitos
  return '$hours:$minutes'; // Formato HH:mm
}