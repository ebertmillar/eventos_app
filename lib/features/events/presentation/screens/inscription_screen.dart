import 'package:eventos_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:eventos_app/features/events/domain/entities/event.dart';
import 'package:eventos_app/features/inscriptions/presentation/providers/form/inscription_form_provider.dart';
import 'package:eventos_app/shared/helpers/form_date.dart';
import 'package:eventos_app/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InscriptionScreen extends ConsumerWidget {
  final Event event;

  const InscriptionScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formState = ref.watch(inscriptionFormProvider);
    final formNotifier = ref.read(inscriptionFormProvider.notifier);
    final currentUser = ref.watch(authProvider).user;
  print('Datos del usuario autenticado: $currentUser');

    // Controladores de texto (conectados al estado)
    final nameController = TextEditingController(text: formState.name);
    final emailController = TextEditingController(text: formState.email);
    final phoneController = TextEditingController(text: formState.phone);

    // Listeners para actualizar el estado al cambiar los valores
    nameController.addListener(() => formNotifier.updateName(nameController.text));
    emailController.addListener(() => formNotifier.updateEmail(emailController.text));
    phoneController.addListener(() => formNotifier.updatePhone(phoneController.text));

    return Scaffold(
      appBar: const CustomAppbar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Resumen del evento
            _EventSummary(
              child: Image.network(
                event.headerImage,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              eventName: event.name,
              eventDate: formatDateRange(event.startDate, event.endDate),
              inscriptionCost: event.inscriptionCost,
            ),
            const SizedBox(height: 20),

            // Formulario de inscripción
            const Text(
              "Detalles de Inscripción",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _CustomTextField(
              controller: nameController,
              label: "Nombre completo",
              hint: "Introduce tu nombre completo",
            ),
            const SizedBox(height: 20),
            _CustomTextField(
              controller: emailController,
              label: "Correo electrónico",
              hint: "Introduce tu correo electrónico",
            ),
            const SizedBox(height: 20),
            _CustomTextField(
              controller: phoneController,
              label: "Teléfono",
              hint: "Introduce tu número de teléfono",
            ),
            const SizedBox(height: 20),

            // Selección de número de entradas
            const Text(
              "Cantidad de entradas",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                IconButton(
                  onPressed: formState.ticketCount > 1
                      ? () => formNotifier.updateTicketCount(
                            formState.ticketCount - 1,
                            event.inscriptionCost,
                          )
                      : null,
                  icon: const Icon(Icons.remove_circle_outline),
                ),
                Text(
                  '${formState.ticketCount}',
                  style: const TextStyle(fontSize: 16),
                ),
                IconButton(
                  onPressed: () => formNotifier.updateTicketCount(
                        formState.ticketCount + 1,
                        event.inscriptionCost,
                      ),
                  icon: const Icon(Icons.add_circle_outline),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Selección de método de pago
            const Text(
              "Método de pago",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _CustomDropdown(
              items: event.paymentMethods,
              hint: "Selecciona un método de pago",
              selectedValue: formState.paymentMethod,
              onChanged: (value) => formNotifier.updatePaymentMethod(value!),
            ),
            const SizedBox(height: 30),

            // Resumen de costo total
            Text(
              "Total a pagar: \$${(event.inscriptionCost * formState.ticketCount).toStringAsFixed(2)}",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 30),

            // Botones de acción
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.orange),
                    ),
                    child: const Text("Volver"),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: ElevatedButton(
                    onPressed: formState.isSubmitting
                        ? null
                        : () async {
                            await formNotifier.submitForm(
                              userId: "user-id-placeholder",
                              eventId: event.id,
                              generateTicketCode: () => "ABC123",
                            );
                            if (!formState.isSubmitting) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Inscripción completada exitosamente"),
                                  backgroundColor: Colors.green,
                                ),
                              );
                              Navigator.pop(context);
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                    ),
                    child: const Text("Inscribirse"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Componente reutilizable: Resumen del evento
class _EventSummary extends StatelessWidget {
  final String eventName;
  final String eventDate;
  final double inscriptionCost;
  final Widget? child;

  const _EventSummary({
    Key? key,
    required this.eventName,
    required this.eventDate,
    required this.inscriptionCost,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            child: child,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  eventName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(Icons.calendar_today, color: Colors.grey, size: 16),
                    const SizedBox(width: 6),
                    Text(
                      eventDate,
                      style: const TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(Icons.attach_money, color: Colors.green, size: 16),
                    const SizedBox(width: 6),
                    Text(
                      "\$${inscriptionCost.toStringAsFixed(2)}",
                      style: const TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Campo de texto personalizado
class _CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;

  const _CustomTextField({
    Key? key,
    required this.controller,
    required this.label,
    required this.hint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: const OutlineInputBorder(),
      ),
    );
  }
}

// Dropdown personalizado
class _CustomDropdown extends StatelessWidget {
  final List<String> items;
  final String hint;
  final String? selectedValue;
  final void Function(String?) onChanged;

  const _CustomDropdown({
    Key? key,
    required this.items,
    required this.hint,
    this.selectedValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: hint,
      ),
      items: items
          .map((item) => DropdownMenuItem(
                value: item,
                child: Text(item),
              ))
          .toList(),
      onChanged: onChanged,
    );
  }
}
