import 'package:flutter/material.dart';

Future<TimeOfDay?> showTimePickerHelper({
  required BuildContext context,
  TimeOfDay? initialTime,
  String? helpText,
}) {
  return showTimePicker(
    context: context,
    initialEntryMode: TimePickerEntryMode.input, // Permite entrada manual
    helpText: helpText, // Texto de ayuda opcional
    initialTime: initialTime ?? TimeOfDay.now(), // Hora inicial por defecto
  );
}