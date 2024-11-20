import 'package:formz/formz.dart';

// Define validation errors for the AdditionalInfo field
enum AdditionalInfoError { invalidCharacters }

// Extend FormzInput and define the input type (String?) and error type (AdditionalInfoError)
class AdditionalInfo extends FormzInput<String?, AdditionalInfoError> {
  // Regular expression to validate allowed characters
  static final RegExp allowedCharactersRegExp = RegExp(
    r'^[a-zA-Z0-9\s.,-]*$', // Allows letters, numbers, spaces, ., , and -
  );

  // Constructor for an unmodified field
  const AdditionalInfo.pure() : super.pure(null);

  // Constructor for a modified field
  const AdditionalInfo.dirty({String value = ''}) : super.dirty(value);

  // Method to provide the associated error message
  String? get errorMessage {
    if (isValid || isPure) return null; // No error if valid or pure

    if (displayError == AdditionalInfoError.invalidCharacters) {
      return 'Contains invalid characters';
    }

    return null;
  }

  // Override validator to handle validation logic
  @override
  AdditionalInfoError? validator(String? value) {
    if (value == null || value.trim().isEmpty) return null; // Valid if empty
    if (!allowedCharactersRegExp.hasMatch(value)) {
      return AdditionalInfoError.invalidCharacters; // Invalid characters
    }
    return null; // Valid if matches the pattern
  }
}
