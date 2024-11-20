import 'package:formz/formz.dart';

// Definir los errores de validación
enum SocialMediaError { empty, invalidFormat }

// Extender FormzInput y proporcionar el tipo de entrada y el tipo de error.
class SocialMedia extends FormzInput<String, SocialMediaError> {
  // Expresión regular para validar URLs, nombres de usuario con @ y nombres simples sin espacios
  static final RegExp validFormatRegExp = RegExp(
    r'^((https?:\/\/)?(www\.)?[a-zA-Z0-9_-]+\.[a-zA-Z]{2,}(:\d+)?(\/.*)?)|(@[a-zA-Z0-9._-]+)|([a-zA-Z0-9._-]+)$',
  );

  // Llamar a super.pure para representar una entrada de formulario no modificada.
  const SocialMedia.pure() : super.pure('');

  // Llamar a super.dirty para representar una entrada de formulario modificada.
  const SocialMedia.dirty({String value = ''}) : super.dirty(value);

  // Obtener el mensaje de error
  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == SocialMediaError.empty) return 'Este campo es requerido';
    if (displayError == SocialMediaError.invalidFormat) {
      return 'Debe ser una URL válida, un @usuario, o un nombre sin espacios ni caracteres no permitidos';
    }

    return null;
  }

  // Sobrescribir el validador para manejar la validación de un valor de entrada dado
  @override
  SocialMediaError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return SocialMediaError.empty;
    if (!validFormatRegExp.hasMatch(value)) return SocialMediaError.invalidFormat;
    return null;
  }
}
