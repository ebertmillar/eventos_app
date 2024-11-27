import 'package:formz/formz.dart';

// Define input validation errors
enum VenueCapacityError { empty, value, format }

// Extend FormzInput and provide the input type and error type.
class VenueCapacity extends FormzInput<int, VenueCapacityError> {

  // Call super.pure to represent an unmodified form input.
  const VenueCapacity.pure() : super.pure(0);

  // Call super.dirty to represent a modified form input.
  const VenueCapacity.dirty({ int value = 0 }) : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == VenueCapacityError.empty) return 'El campo es requerido';
    if (displayError == VenueCapacityError.value) return 'Debe ser un número mayor o igual a 1';
    if (displayError == VenueCapacityError.format) return 'Debe ser un número válido';

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  VenueCapacityError? validator(int value) {
    if (value.toString().isEmpty || value.toString().trim().isEmpty) {
      return VenueCapacityError.empty;
    }

    final isInteger = int.tryParse(value.toString()) ?? -1;
    if (isInteger == -1) {
      return VenueCapacityError.format;
    }

    if (value < 1) {
      return VenueCapacityError.value;
    }

    return null;
  }
}
