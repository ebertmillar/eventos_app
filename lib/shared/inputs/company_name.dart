import 'package:formz/formz.dart';

// Definir los errores de validación
enum CompanyNameError { empty, format }

// Extender FormzInput y proporcionar el tipo de entrada y el tipo de error.
class CompanyName extends FormzInput<String, CompanyNameError> {
  // Expresión regular para permitir letras, números, espacios y algunos caracteres especiales comunes en nombres de empresas (como punto, coma, y, y guion)
  static final RegExp companyNameRegExp = RegExp(
    r'^[a-zA-ZÀ-ÿ0-9\s,\.&-]+$', // Añadido soporte para caracteres con tildes (À-ÿ)
    caseSensitive: false,
  );
  // Llamar a super.pure para representar una entrada de formulario no modificada.
  const CompanyName.pure() : super.pure('');

  // Llamar a super.dirty para representar una entrada de formulario modificada.
  const CompanyName.dirty({String value = ''}) : super.dirty(value);

  // Obtener el mensaje de error
  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == CompanyNameError.empty) return 'El nombre de empresa es requerido';
    if (displayError == CompanyNameError.format) {
      return 'El nombre de la empresa solo puede contener letras, números, espacios y algunos caracteres especiales como ., -, y &';
    }

    return null;
  }

  // Sobrescribir el validador para manejar la validación de un valor de entrada dado
  @override
  CompanyNameError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return CompanyNameError.empty;
    if (!companyNameRegExp.hasMatch(value)) return CompanyNameError.format;
    return null;
  }
}
