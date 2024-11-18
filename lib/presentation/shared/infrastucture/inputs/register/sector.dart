import 'package:formz/formz.dart';

// Define input validation errors
enum SectorError { empty }

// Extend FormzInput and provide the input type and error type.
class Sector extends FormzInput<String, SectorError> {
  // Valor por defecto que no se debe permitir
  static const String defaultValue = 'Introduce el sector al que te dedicas';

  // Call super.pure to represent an unmodified form input.
  const Sector.pure() : super.pure(defaultValue);

  // Call super.dirty to represent a modified form input.
  const Sector.dirty({String value = defaultValue}) : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == SectorError.empty) return 'Debes seleccionar un sector';

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  SectorError? validator(String value) {
    // Verificar si el sector es el valor por defecto, que no es válido
    if (value == defaultValue || value.trim().isEmpty) return SectorError.empty;

    return null;
  }
}
