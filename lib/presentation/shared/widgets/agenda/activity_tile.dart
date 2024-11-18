import 'package:flutter/material.dart';
import 'package:eventos_app/domain/entities/agenda_day.dart';

class ActivityTile extends StatelessWidget {
  final Activity activity;
  final VoidCallback onDelete;

  const ActivityTile({
    super.key,
    required this.activity,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 0.0), // Espaciado 
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              '${activity.startTime} - ${activity.endTime}: ${activity.description}',
              style: const TextStyle(fontSize: 14, color: Colors.black87, height: 1.0),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.black45),
            padding: EdgeInsets.zero,
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}
