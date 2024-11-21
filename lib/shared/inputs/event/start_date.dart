import 'package:formz/formz.dart';
import 'package:intl/intl.dart';

enum StartDateError { empty, invalid, pastDate, invalidCharacters }

class StartDate extends FormzInput<DateTime?, StartDateError> {
  const StartDate.pure() : super.pure(null);
  const StartDate.dirty({DateTime? value}) : super.dirty(value);

  @override
  StartDateError? validator(DateTime? value) {
    if (value == null) return StartDateError.empty;
    final today = DateTime.now();
    final currentDate = DateTime(today.year, today.month, today.day);
    if (value.isBefore(currentDate)) return StartDateError.pastDate;
    return null;
  }

  String? get errorMessage {
    if (isValid || isPure) return null;
    switch (displayError) {
      case StartDateError.empty:
        return 'La fecha no puede estar vacía.';
      case StartDateError.invalid:
        return 'Formato de fecha inválido.';
      case StartDateError.pastDate:
        return 'La fecha no puede ser anterior a hoy.';
      case StartDateError.invalidCharacters:
        return 'Solo se permiten números y "/"';
      default:
        return null;
    }
  }

  static StartDateError? validateDateFormat(String text) {
  // Validar que solo contenga números y '/'
  final validCharactersRegExp = RegExp(r'^[0-9/]+$');
  if (!validCharactersRegExp.hasMatch(text)) {
    return StartDateError.invalidCharacters;
  }

  // Validar el formato de fecha
  try {
    DateFormat('dd/MM/yyyy').parseStrict(text);
    return null; // Formato válido
  } catch (e) {
    return StartDateError.invalid;
  }
}
}
