import 'package:eventos_app/features/events/presentation/providers/create_event_form_provider.dart';
import 'package:eventos_app/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as path;

class FilePickerField extends ConsumerWidget {
  final String label;
  final String? hint;
  final Color borderColor;

  const FilePickerField({
    super.key,
    required this.label,
    this.hint,
    this.borderColor = Colors.black45,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventFormState = ref.watch(createEventFormProvider);
    final eventFormNotifier = ref.read(createEventFormProvider.notifier);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 30, left: 10, bottom: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: borderColor),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if ((eventFormState.attachedDocument ?? []).isNotEmpty)
                  Column(
                    children: eventFormState.attachedDocument!
                        .map((filePath) => ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text(
                                path.basename(filePath), // Extraer solo el nombre del archivo
                                style: const TextStyle(fontSize: 14),
                              ),
                              trailing: IconButton(
                                icon: const Icon(Icons.clear, color: Colors.red),
                                onPressed: () {
                                  final index = eventFormState.attachedDocument!
                                      .indexOf(filePath);
                                  eventFormNotifier.removeFile(index);
                                },
                              ),
                            ))
                        .toList(),
                  ),
                if ((eventFormState.attachedDocument ?? []).isEmpty && hint != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 0, left: 5),
                    child: Text(
                      hint!,
                      style: const TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                  ),
                const SizedBox(height: 25),
                Align(
                  alignment: Alignment.center,
                  child: CustomFilledButton(
                    text: '+ Añadir documnetos',
                    textColor: Colors.orange[500],
                    onPressed: () async {
                      await eventFormNotifier.pickFiles();
                    },
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          Positioned(
            left: 10,
            top: 5,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              color: Colors.white,
              child: Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
