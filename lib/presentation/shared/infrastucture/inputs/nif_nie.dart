import 'package:formz/formz.dart';

// Define input validation errors for NIF/NIE
enum NifNieError { empty, format }

// Extend FormzInput and provide the input type and error type.
class NifNie extends FormzInput<String, NifNieError> {
  // Regular expression to validate NIF or NIE for Spain
  static final RegExp nifNieRegExp = RegExp(
    r'^[XYZ]?\d{7,8}[A-Z]$',
  );

  // Call super.pure to represent an unmodified form input.
  const NifNie.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const NifNie.dirty({String value = ''}) : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == NifNieError.empty) return 'El campo es requerido';
    if (displayError == NifNieError.format) {
      // Detecta si es NIF o NIE según el primer carácter
      if (value.startsWith(RegExp(r'[XYZ]'))) {
        return 'El NIE ingresado no es válido';
      } else {
        return 'El NIF ingresado no es válido';
      }
    }

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  NifNieError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return NifNieError.empty;
    if (!nifNieRegExp.hasMatch(value)) return NifNieError.format;

    // Verifica la validez del NIF/NIE (cálculo de la letra final)
    if (!_validateNifNie(value)) return NifNieError.format;

    return null;
  }

  bool _validateNifNie(String nifNie) {
    const letters = 'TRWAGMYFPDXBNJZSQVHLCKE';

    // Convertir NIE al formato de NIF (cambiando X, Y, Z a dígitos)
    if (nifNie.startsWith('X')) {
      nifNie = '0${nifNie.substring(1)}';
    } else if (nifNie.startsWith('Y')) {
      nifNie = '1${nifNie.substring(1)}';
    } else if (nifNie.startsWith('Z')) {
      nifNie = '2${nifNie.substring(1)}';
}

    // Asegurar que el formato es correcto después de conversión de NIE
    if (!RegExp(r'^\d{8}[A-Z]$').hasMatch(nifNie)) return false;

    final dniNumber = int.tryParse(nifNie.substring(0, 8));
    final expectedLetter = nifNie[8];
    final calculatedLetter = letters[dniNumber! % 23];

    return calculatedLetter == expectedLetter;
  }
}
