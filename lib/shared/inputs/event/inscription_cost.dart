import 'package:formz/formz.dart';

// Define validation errors
enum InscriptionCostError { empty, negative, outOfRange }

// Extend FormzInput to handle input and error types
class InscriptionCost extends FormzInput<double, InscriptionCostError> {
  // Call super.pure to represent an unmodified form input
  const InscriptionCost.pure() : super.pure(0.0);

  // Call super.dirty to represent a modified form input
  const InscriptionCost.dirty({double value = 0.0}) : super.dirty(value);

  // Get the error message
  String? get errorMessage {
    if (isValid || isPure) return null;

    switch (displayError) {
      case InscriptionCostError.empty:
        return 'El costo no puede estar vacío.';
      case InscriptionCostError.negative:
        return 'El costo no puede ser negativo.';
      case InscriptionCostError.outOfRange:
        return 'El costo debe estar entre 0 y 1,000,000.';
      default:
        return null;
    }
  }

  // Override the validator to handle validation for the given input value
  @override
  InscriptionCostError? validator(double value) {
    // Validate that the value is not empty or zero
    if (value.toString().isEmpty) return InscriptionCostError.empty;

    // Validate that the number is not negative
    if (value < 0) return InscriptionCostError.negative;

    // Validate that the number is within the allowed range
    if (value > 1000000) return InscriptionCostError.outOfRange;

    return null; // No errors
  }
}
