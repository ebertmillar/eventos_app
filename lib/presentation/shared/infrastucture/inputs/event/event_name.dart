import 'package:formz/formz.dart';

// Definir los errores de validación
enum EventNameError { empty, format }

// Extender FormzInput y proporcionar el tipo de entrada y el tipo de error.
class EventName extends FormzInput<String, EventNameError> {
  // Expresión regular para permitir letras, números, espacios y algunos caracteres especiales comunes en títulos (como punto, coma, y guion)
  static final RegExp titleRegExp = RegExp(r'^[a-zA-Z0-9\s,\.&-]+$');

  // Llamar a super.pure para representar una entrada de formulario no modificada.
  const EventName.pure() : super.pure('');

  // Llamar a super.dirty para representar una entrada de formulario modificada.
  const EventName.dirty({String value = ''}) : super.dirty(value);

  // Obtener el mensaje de error
  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == EventNameError.empty) return 'El título es obligatorio';
    if (displayError == EventNameError.format) {
      return 'El título solo puede contener letras, números, espacios y algunos caracteres especiales como ., -, y &';
    }

    return null;
  }

  // Sobrescribir el validador para manejar la validación de un valor de entrada dado
  @override
  EventNameError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return EventNameError.empty;
    if (!titleRegExp.hasMatch(value)) return EventNameError.format;
    return null;
  }
}
