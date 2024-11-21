import 'package:formz/formz.dart';

// Define validation errors
enum InscriptionCostError { empty, notANumber, negative, outOfRange }

// Extend FormzInput to handle input and error types
class InscriptionCost extends FormzInput<String, InscriptionCostError> {
  // Call super.pure to represent an unmodified form input
  const InscriptionCost.pure() : super.pure('');

  // Call super.dirty to represent a modified form input
  const InscriptionCost.dirty({String value = ''}) : super.dirty(value);

  // Get the error message
  String? get errorMessage {
    if (isValid || isPure) return null;

    switch (displayError) {
      case InscriptionCostError.empty:
        return 'The cost cannot be empty.';
      case InscriptionCostError.notANumber:
        return 'The cost must be a valid number.';
      case InscriptionCostError.negative:
        return 'The cost cannot be negative.';
      case InscriptionCostError.outOfRange:
        return 'The cost must be between 0 and 1,000,000.';
      default:
        return null;
    }
  }

  // Override the validator to handle validation for the given input value
  @override
  InscriptionCostError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return InscriptionCostError.empty;

    // Validate that the value is a decimal number
    final number = double.tryParse(value.replaceAll(',', '').trim());
    if (number == null) return InscriptionCostError.notANumber;

    // Validate that the number is not negative
    if (number < 0) return InscriptionCostError.negative;

    // Validate that the number is within the allowed range
    if (number > 1000000) return InscriptionCostError.outOfRange;

    return null; // No errors
  }
}
