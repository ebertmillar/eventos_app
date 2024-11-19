import 'package:formz/formz.dart';


enum InscriptionEndDateError { invalid, beforeStart, afterEventStart }

class InscriptionEndDate extends FormzInput<DateTime?, InscriptionEndDateError> {
  final DateTime? inscriptionStartDate;
  final DateTime? eventStartDate;

  const InscriptionEndDate.pure({this.inscriptionStartDate, this.eventStartDate}) : super.pure(null);
  const InscriptionEndDate.dirty({
    this.inscriptionStartDate,
    this.eventStartDate,
    DateTime? value,
  }) : super.dirty(value);

  @override
  InscriptionEndDateError? validator(DateTime? value) {
    if (value == null) return InscriptionEndDateError.invalid;
    if (inscriptionStartDate != null && value.isBefore(inscriptionStartDate!)) {
      return InscriptionEndDateError.beforeStart;
    }
    if (eventStartDate != null && value.isAfter(eventStartDate!)) {
      return InscriptionEndDateError.afterEventStart;
    }
    return null;
  }

  // Método para obtener el mensaje de error
  String? get errorMessage {
    if (isValid || isPure) return null;

    switch (displayError) {
      case InscriptionEndDateError.invalid:
        return 'Fecha no valida';
      case InscriptionEndDateError.beforeStart:
        return 'Fecha anterior al incio de isncripcion';
      case InscriptionEndDateError.afterEventStart:
        return 'Fecha despues del evento';
      default:
        return null;
    }
  }
}
