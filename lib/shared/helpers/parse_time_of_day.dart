import 'package:flutter/material.dart';

TimeOfDay parseTimeOfDay(String timeString) {
  final parts = timeString.split(':');
  if (parts.length != 2) {
    throw const FormatException('Invalid time format, expected HH:mm');
  }
  final hour = int.parse(parts[0]);
  final minute = int.parse(parts[1]);
  return TimeOfDay(hour: hour, minute: minute);
}