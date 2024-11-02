import 'package:flutter/material.dart';


class CustomSectorFormField extends StatelessWidget {
  final String? label;
  final String? hint;
  final List<String> items;
  final String? value;
  final ValueChanged<String?>? onChanged;

  const CustomSectorFormField({
    super.key,
    this.label,
    this.hint,
    this.value,
    this.onChanged,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(padding: const EdgeInsets.only(top: 5.0, left: 10.0,  right: 10.0),
                  child: Text('$label',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.fromLTRB(10, 0, 10, 4),
                    isDense: true,
                  ),
                  hint: const Text(
                    'Seleccione un sector',
                    style: TextStyle(color: Colors.grey),
                  ),
                  items: <String>[
                    'Sector 1',
                    'Sector 2',
                    'Sector 3'
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,
                          style: const TextStyle(
                              color: Colors.black)),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    // Aquí puedes manejar el cambio de selección
                  },
                  style: const TextStyle(color: Colors.black),
                ),
              ],
            ),
          );
        }
}