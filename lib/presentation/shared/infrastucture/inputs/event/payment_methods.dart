  import 'package:formz/formz.dart';

// Definir los errores de validación
enum PaymentMethodsError { empty }

// Extender FormzInput para manejar una lista de métodos de pago
class PaymentMethods extends FormzInput<List<String>, PaymentMethodsError> {
  // Llamar a super.pure para representar una entrada de formulario no modificada
  const PaymentMethods.pure() : super.pure(const []);

  // Llamar a super.dirty para representar una entrada de formulario modificada
  const PaymentMethods.dirty({List<String> value = const []}) : super.dirty(value);

  // Obtener el mensaje de error
  String? get errorMessage {
    if (isValid || isPure) return null;

    switch (displayError) {
      case PaymentMethodsError.empty:
        return 'Debe seleccionar al menos un método de pago.';
      default:
        return null;
    }
  }

  // Sobrescribir el validador para manejar la validación de un valor de entrada dado
  @override
  PaymentMethodsError? validator(List<String> value) {
    if (value.isEmpty) return PaymentMethodsError.empty;
    return null; // Sin errores
  }
}
