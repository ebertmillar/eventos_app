import 'package:formz/formz.dart';

enum InscriptionStartDateError { invalid, afterEventStart }

class InscriptionStartDate extends FormzInput<DateTime?, InscriptionStartDateError> {
  final DateTime? eventStartDate;

  const InscriptionStartDate.pure({this.eventStartDate}) : super.pure(null);
  const InscriptionStartDate.dirty({this.eventStartDate, DateTime? value}) : super.dirty(value);

  @override
  InscriptionStartDateError? validator(DateTime? value) {
    if (value == null) return InscriptionStartDateError.invalid;
    if (eventStartDate != null && value.isAfter(eventStartDate!)) {
      return InscriptionStartDateError.afterEventStart;
    }
    return null;
  }

  // Método para obtener el mensaje de error
  String? get errorMessage {
    if (isValid || isPure) return null;

    switch (displayError) {
      case InscriptionStartDateError.invalid:
        return 'Fecha no valida';
      case InscriptionStartDateError.afterEventStart:
        return 'Fecha despue de inicio del evento.';
      default:
        return null;
    }
  }
}