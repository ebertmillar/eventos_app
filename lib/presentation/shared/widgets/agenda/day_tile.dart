import 'package:eventos_app/presentation/shared/widgets/agenda/activity_tile.dart';
import 'package:flutter/material.dart';
import 'package:eventos_app/domain/entities/agenda_day.dart';

class DayTile extends StatelessWidget {
  final AgendaDay day;
  final VoidCallback onDeleteDay;
  final void Function(BuildContext context, String dia) onAddActivity;
  final void Function(String dia, int index) onDeleteActivity;

  const DayTile({
    super.key,
    required this.day,
    required this.onDeleteDay,
    required this.onAddActivity,
    required this.onDeleteActivity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black45),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ExpansionTile(
  title: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        day.day,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87),
      ),
      IconButton(
        icon: const Icon(Icons.close, color: Colors.black54),
        visualDensity: VisualDensity.compact,
        onPressed: onDeleteDay,
      ),
    ],
  ),
  children: [
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0), // Padding manual para los hijos
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ...day.activities.asMap().entries.map((entry) {
            final index = entry.key;
            final activity = entry.value;

            return ActivityTile(
              activity: activity,
              onDelete: () => onDeleteActivity(day.day, index),
            );
          }).toList(),
          Center(
            child: TextButton(
              onPressed: () => onAddActivity(context, day.day),
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
              ),
              child: const Text(
                '+ Agregar actividad',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
            ),
          ),
        ],
      ),
    ),
  ],
),


    );
  }
}
