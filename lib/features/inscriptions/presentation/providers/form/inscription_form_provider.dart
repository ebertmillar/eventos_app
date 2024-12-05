import 'package:eventos_app/features/inscriptions/presentation/providers/inscriptions_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final inscriptionFormProvider = StateNotifierProvider.autoDispose<InscriptionFormNotifier, InscriptionFormState>((ref) {
  final onSubmitCallback = ref.watch(inscriptionsProvider.notifier).createInscription;
  return InscriptionFormNotifier(onSubmitCallback);
});

class InscriptionFormNotifier extends StateNotifier<InscriptionFormState> {

  final Future<bool> Function(Map<String, dynamic> inscriptionData)? onSubmitCallback;

  InscriptionFormNotifier(this.onSubmitCallback) : super(InscriptionFormState());

  // Actualizar nombre
  void updateName(String name) {
    state = state.copyWith(name: name, isValid: _validateForm());
  }

  // Actualizar email
  void updateEmail(String email) {
    state = state.copyWith(email: email, isValid: _validateForm());
  }

  // Actualizar teléfono
  void updatePhone(String phone) {
    state = state.copyWith(phone: phone, isValid: _validateForm());
  }

  // Actualizar cantidad de entradas
  void updateTicketCount(int count, double eventCost) {
    final newTotal = count * eventCost;
    state = state.copyWith(ticketCount: count, totalAmount: newTotal, isValid: _validateForm());
  }

  // Actualizar método de pago
  void updatePaymentMethod(String method) {
    state = state.copyWith(paymentMethod: method, isValid: _validateForm());
  }

  // Validar el formulario
  bool _validateForm() {
    return state.name.isNotEmpty &&
        state.email.isNotEmpty &&
        state.phone.isNotEmpty &&
        state.ticketCount > 0 &&
        state.paymentMethod.isNotEmpty;
  }

  Future<void> submitForm({
    required String userId,
    required String eventId,
    required String Function() generateTicketCode,
  }) async {
    if (!state.isValid) return; // No enviar si no es válido

    state = state.copyWith(isSubmitting: true);

    final inscriptionData = {
      'id': state.id ?? '',
      'userId': userId,
      'eventId': eventId,
      'amountPaid': state.totalAmount,
      'date': DateTime.now().toIso8601String(),
      'paymentMethod': state.paymentMethod,
      'ticketCode': generateTicketCode(),
      'isPaid': true,
      'status': 'confirmed',
    };

    try {
      if (onSubmitCallback != null) {
        final success = await onSubmitCallback!(inscriptionData);
        if (!success) throw Exception('Error al registrar la inscripción');
      }

      state = state.copyWith(isSubmitting: false);
      print('Formulario enviado correctamente');
    } catch (e) {
      state = state.copyWith(isSubmitting: false);
      print('Error al enviar el formulario: $e');
    }
  }
}

class InscriptionFormState {
  final String name; // Nombre del usuario
  final String email; // Correo del usuario
  final String phone; // Teléfono del usuario
  final int ticketCount; // Cantidad de entradas seleccionadas
  final String paymentMethod; // Método de pago seleccionado
  final double totalAmount; // Monto total calculado
  final bool isValid; // Si el formulario es válido
  final bool isSubmitting; // Si se está procesando el formulario
  final String? id; // Identificador único para ediciones

  InscriptionFormState({
    this.name = '',
    this.email = '',
    this.phone = '',
    this.ticketCount = 1,
    this.paymentMethod = '',
    this.totalAmount = 0.0,
    this.isValid = false,
    this.isSubmitting = false,
    this.id,
  });

  InscriptionFormState copyWith({
    String? name,
    String? email,
    String? phone,
    int? ticketCount,
    String? paymentMethod,
    double? totalAmount,
    bool? isValid,
    bool? isSubmitting,
    String? id,
  }) {
    return InscriptionFormState(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      ticketCount: ticketCount ?? this.ticketCount,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      totalAmount: totalAmount ?? this.totalAmount,
      isValid: isValid ?? this.isValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      id: id ?? this.id,
    );
  }
}
