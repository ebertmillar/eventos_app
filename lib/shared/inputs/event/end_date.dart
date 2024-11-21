import 'package:formz/formz.dart';
import 'package:intl/intl.dart';

enum EndDateError { empty, beforeStartDate, invalidFormat, invalidCharacters }

class EndDate extends FormzInput<DateTime?, EndDateError> {
  final DateTime? startDate;

  const EndDate.pure({this.startDate}) : super.pure(null);

  const EndDate.dirty({this.startDate, DateTime? value}) : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;

    switch (displayError) {
      case EndDateError.empty:
        return 'Fecha no válida';
      case EndDateError.beforeStartDate:
        return 'La fecha de fin debe ser mayor o igual a la fecha de inicio';
      case EndDateError.invalidFormat:
        return 'Formato de fecha inválido (dd/MM/yyyy)';
      case EndDateError.invalidCharacters:
        return 'Solo se permiten números y el carácter "/"';
      default:
        return null;
    }
  }

  @override
  EndDateError? validator(DateTime? value) {
    if (value == null) return EndDateError.empty;
    if (startDate != null && value.isBefore(startDate!)) {
      return EndDateError.beforeStartDate;
    }
    return null;
  }

  static EndDateError? validateDateFormat(String text, DateTime? startDate) {
    final validCharactersRegExp = RegExp(r'^[0-9/]+$');
    if (!validCharactersRegExp.hasMatch(text)) {
      return EndDateError.invalidCharacters;
    }

    try {
      final date = DateFormat('dd/MM/yyyy').parseStrict(text);
      if (startDate != null && date.isBefore(startDate)) {
        return EndDateError.beforeStartDate;
      }
      return null;
    } catch (e) {
      return EndDateError.invalidFormat;
    }
  }
}
