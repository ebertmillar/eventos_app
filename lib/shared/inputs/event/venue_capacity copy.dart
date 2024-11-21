import 'package:formz/formz.dart';

// Definir los errores de validación
enum VenueCapacityError { empty, notANumber, outOfRange }

// Extender FormzInput y proporcionar el tipo de entrada y el tipo de error
class VenueCapacity extends FormzInput<String, VenueCapacityError> {
  // Llamar a super.pure para representar una entrada de formulario no modificada
  const VenueCapacity.pure() : super.pure('');

  // Llamar a super.dirty para representar una entrada de formulario modificada
  const VenueCapacity.dirty({String value = ''}) : super.dirty(value);

  // Obtener el mensaje de error
  String? get errorMessage {
    if (isValid || isPure) return null;

    switch (displayError) {
      case VenueCapacityError.empty:
        return 'La capacidad no puede estar vacía.';
      case VenueCapacityError.notANumber:
        return 'La capacidad debe ser un número válido.';
      case VenueCapacityError.outOfRange:
        return 'La capacidad debe estar entre 1 y 100,000.';
      default:
        return null;
    }
  }

  // Sobrescribir el validador para manejar la validación de un valor de entrada dado
  @override
  VenueCapacityError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return VenueCapacityError.empty;

    // Validar que el valor sea un número entero
    final number = int.tryParse(value);
    if (number == null) return VenueCapacityError.notANumber;

    // Validar que el número esté dentro del rango permitido
    if (number <= 0 || number > 100000) return VenueCapacityError.outOfRange;

    return null; // Sin errores
  }
}
