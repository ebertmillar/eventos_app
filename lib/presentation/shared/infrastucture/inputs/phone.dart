import 'package:formz/formz.dart';

// Define input validation errors
enum PhoneError { empty, format }

// Extend FormzInput and provide the input type and error type.
class Phone extends FormzInput<String, PhoneError> {
  static final RegExp phoneRegExp = RegExp(
    r'^\+?\d{1,4}?[.\-\s]?\(?\d{1,4}?\)?[.\-\s]?\d{1,4}[.\-\s]?\d{1,4}$',
  );

  // Call super.pure to represent an unmodified form input.
  const Phone.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const Phone.dirty({String value = ''}) : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == PhoneError.empty) return 'El número de teléfono es requerido';
    if (displayError == PhoneError.format) {
      return 'El formato del número de teléfono es incorrecto';
    }

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  PhoneError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return PhoneError.empty;
    if (!phoneRegExp.hasMatch(value)) return PhoneError.format;

    return null;
  }
}
