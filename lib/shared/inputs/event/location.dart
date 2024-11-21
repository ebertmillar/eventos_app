import 'package:formz/formz.dart';

// Definir los errores de validación
enum LocationError { empty, invalidFormat }

// Extender FormzInput y proporcionar el tipo de entrada y el tipo de error.
class Location extends FormzInput<String, LocationError> {
  // Expresiones regulares para validar enlaces web y direcciones físicas
  static final RegExp webUrlRegExp = RegExp(
    r'^(https?:\/\/)?([\w-]+\.)+[\w-]{2,4}\/?.*$',
    caseSensitive: false,
  );
  static final RegExp physicalAddressRegExp = RegExp(
    r'^[a-zA-Z0-9\s,.\-#]+$',
    caseSensitive: false,
  );

  // Llamar a super.pure para representar una entrada de formulario no modificada.
  const Location.pure() : super.pure('');

  // Llamar a super.dirty para representar una entrada de formulario modificada.
  const Location.dirty({String value = ''}) : super.dirty(value);

  // Obtener el mensaje de error
  String? get errorMessage {
    if (isValid || isPure) return null;

    switch (displayError) {
      case LocationError.empty:
        return 'La ubicación es obligatoria';
      case LocationError.invalidFormat:
        return 'Debe ser una dirección válida o un enlace web';
      default:
        return null;
    }
  }

  // Sobrescribir el validador para manejar la validación de un valor de entrada dado.
  @override
  LocationError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return LocationError.empty;

    // Verificar si es una dirección física o un enlace web válido
    if (!physicalAddressRegExp.hasMatch(value) && !webUrlRegExp.hasMatch(value)) {
      return LocationError.invalidFormat;
    }

    return null; // Sin errores
  }
}
