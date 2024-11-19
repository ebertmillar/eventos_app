import 'package:formz/formz.dart';

// Definir los errores de validación
enum DescriptionError { empty, tooShort }

// Extender FormzInput y proporcionar el tipo de entrada y el tipo de error.
class Description extends FormzInput<String, DescriptionError> {
  // Llamar a super.pure para representar una entrada de formulario no modificada.
  const Description.pure() : super.pure('');

  // Llamar a super.dirty para representar una entrada de formulario modificada.
  const Description.dirty({String value = ''}) : super.dirty(value);

  // Obtener el mensaje de error
  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == DescriptionError.empty) return 'La descripción es obligatoria';
    if (displayError == DescriptionError.tooShort) {
      return 'La descripción debe tener al menos 10 caracteres';
    }

    return null;
  }

  // Sobrescribir el validador para manejar la validación de un valor de entrada dado.
  @override
  DescriptionError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return DescriptionError.empty;
    if (value.trim().length < 10) return DescriptionError.tooShort;
    return null;
  }
}
