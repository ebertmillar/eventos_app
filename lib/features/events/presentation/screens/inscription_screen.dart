import 'package:eventos_app/features/events/domain/entities/event.dart';
import 'package:eventos_app/shared/helpers/form_date.dart';
import 'package:eventos_app/shared/shared.dart';
import 'package:flutter/material.dart';

class InscriptionScreen extends StatelessWidget {
  
  final Event event;

  const InscriptionScreen({super.key, required this.event});

    @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    

    return Scaffold(
      appBar: const CustomAppbar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header con información básica del evento
            _EventSummary(
              child: Image.network(event.headerImage,
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
            _CustomTextField(label: "Nombre completo", hint: "Introduce tu nombre completo"),
            const SizedBox(height: 20),
            _CustomTextField(label: "Correo electrónico", hint: "Introduce tu correo electrónico"),
            const SizedBox(height: 20),
            _CustomTextField(label: "Teléfono", hint: "Introduce tu número de teléfono"),
            const SizedBox(height: 20),

            // Selección de método de pago
            const Text(
              "Método de pago",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _CustomDropdown(
              items: const ["Tarjeta de crédito", "Transferencia", "Paypal"],
              hint: "Selecciona un método de pago",
            ),
            const SizedBox(height: 30),

            // Botones de acción
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.orange),
                    ),
                    child: const Text("Volver"),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Acción al presionar "Inscribirse"
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Inscripción completada exitosamente")),
                      );
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
    required this.child
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15), // Bordes redondeados
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Imagen del evento en la parte superior
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            child:child,
          ),
          // Contenido del evento (nombre, fecha, costo)
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

class _CustomTextField extends StatelessWidget {
  final String label;
  final String hint;

  const _CustomTextField({Key? key, required this.label, required this.hint}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: const OutlineInputBorder(),
      ),
    );
  }
}

class _CustomDropdown extends StatelessWidget {
  final List<String> items;
  final String hint;

  const _CustomDropdown({Key? key, required this.items, required this.hint}) : super(key: key);

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
      onChanged: (value) {
        // Lógica al seleccionar un método
      },
    );
  }
}