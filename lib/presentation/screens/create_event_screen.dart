import 'package:eventos_app/presentation/shared/shared.dart';
import 'package:flutter/material.dart';

class CreateEventScreen extends StatelessWidget {
  const CreateEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppbar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 24),
            // Línea de tiempo centrada en la pantalla
            Center(child: buildProgressBar(activeStep: 1)),
            SizedBox(height: 24),

            // Contenido del formulario
            buildSectionTitle("Nombre del Evento"),
            buildTextField("Nombre Oficial del Evento"),
            buildSectionTitle("Descripción del Evento"),
            buildTextField("Breve explicación del tema", maxLines: 3),
            buildSectionTitle("Fechas de inicio y final"),
            Row(
              children: [
                Expanded(child: buildDateField("Día de Inicio")),
                SizedBox(width: 8),
                Expanded(child: buildDateField("Día Final")),
              ],
            ),
            buildSectionTitle("Hora de inicio y final"),
            Row(
              children: [
                Expanded(child: buildTimeField("Hora de Inicio")),
                SizedBox(width: 8),
                Expanded(child: buildTimeField("Hora Final")),
              ],
            ),
            Row(
              children: [
                Checkbox(
                  value: false,
                  onChanged: (value) {},
                ),
                Expanded(
                  child: Text(
                    "¿Cada día comienza y termina a una hora distinta?",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            buildSectionTitle("Ubicación"),
            buildTextField("Dirección física o virtual (link de la reunión)"),
            buildSectionTitle("Imagen de cabecera"),
            buildFileUploadField(),
            SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: buildButton("Cancelar", Colors.grey[300], Colors.black),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: buildButton("Siguiente", Colors.orange, Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProgressBar({required int activeStep}) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildStepIndicator(isActive: activeStep >= 1),
            buildConnectorLine(isActive: activeStep >= 2),
            buildStepIndicator(isActive: activeStep >= 2),
            buildConnectorLine(isActive: activeStep >= 3),
            buildStepIndicator(isActive: activeStep >= 3),
            buildConnectorLine(isActive: activeStep >= 4),
            buildStepIndicator(isActive: activeStep >= 4),
          ],
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                "Datos del Evento",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 10),
              ),
            ),
            Expanded(
              child: Text(
                "Inscripciones",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 10),
              ),
            ),
            Expanded(
              child: Text(
                "Agenda",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 10),
              ),
            ),
            Expanded(
              child: Text(
                "Datos de Contacto",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 10),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildStepIndicator({required bool isActive}) {
    return CircleAvatar(
      radius: 6, // Tamaño reducido del indicador
      backgroundColor: isActive ? Colors.orange : Colors.grey,
    );
  }

  Widget buildConnectorLine({required bool isActive}) {
    return Expanded(
      child: Container(
        height: 1, // Tamaño reducido de la línea
        color: isActive ? Colors.orange : Colors.grey,
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }

  Widget buildTextField(String hintText, {int maxLines = 1}) {
    return TextFormField(
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }

  Widget buildDateField(String hintText) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        suffixIcon: Icon(Icons.calendar_today, color: Colors.grey),
      ),
    );
  }

  Widget buildTimeField(String hintText) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        suffixIcon: Icon(Icons.access_time, color: Colors.grey),
      ),
    );
  }

  Widget buildFileUploadField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: "Carga una imagen",
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        suffixIcon: Icon(Icons.upload_file, color: Colors.grey),
      ),
    );
  }

  Widget buildButton(String text, Color? color, Color textColor) {
    return ElevatedButton(
      onPressed: () {
        // Acción del botón
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(color: textColor, fontSize: 16),
      ),
    );
  }
}
