import 'package:formz/formz.dart';

// Definir los errores de validación
enum FullNameError { empty, format }

// Extender FormzInput y proporcionar el tipo de entrada y el tipo de error.
class FullName extends FormzInput<String, FullNameError> {
  // Expresión regular para permitir solo letras y espacios
  static final RegExp fullNameRegExp = RegExp(r'^[a-zA-Z\s]+$');

  // Llamar a super.pure para representar una entrada de formulario no modificada.
  const FullName.pure() : super.pure('');

  // Llamar a super.dirty para representar una entrada de formulario modificada.
  const FullName.dirty({String value = ''}) : super.dirty(value);

  // Obtener el mensaje de error
  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == FullNameError.empty) return 'El nombre es requerido';
    if (displayError == FullNameError.format) {
      return 'El nombre solo puede contener letras y espacios';
    }

    return null;
  }

  // Sobrescribir el validador para manejar la validación de un valor de entrada dado
  @override
  FullNameError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return FullNameError.empty;
    if (!fullNameRegExp.hasMatch(value)) return FullNameError.format;
    return null;
  }
}
