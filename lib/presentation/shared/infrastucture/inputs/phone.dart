import 'package:formz/formz.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

// Define input validation errors
enum PhoneError { empty, format }

// Extend FormzInput and provide the input type and error type.
class Phone extends FormzInput<String, PhoneError> {
  static final RegExp phoneRegExp = RegExp(
    r'^\+?([0-9]{1,4})?([0-9]{10,15})$', // Expresión regular para formato de teléfono
  );

  // Usamos MaskTextInputFormatter para aplicar el formato
  static final maskFormatter = MaskTextInputFormatter(
    mask: '### ### ###',
    filter: {"#": RegExp(r'[0-9]')},
  );

  // Call super.pure to represent an unmodified form input.
  const Phone.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const Phone.dirty({String value = ''}) : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == PhoneError.empty) return 'El teléfono es requerido';
    if (displayError == PhoneError.format) {
      return 'Número de teléfono no válido';
    }

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  PhoneError? validator(String value) {
    // Primero formateamos el número con la máscara
    final formattedValue = maskFormatter.getMaskedText();
    
    if (formattedValue.isEmpty) return PhoneError.empty;
    if (!phoneRegExp.hasMatch(formattedValue)) return PhoneError.format;

    return null;
  }

  // Método para obtener el número formateado
  String get formattedPhoneNumber {
    return maskFormatter.getMaskedText();
  }
}
