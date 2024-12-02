
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;

class FilePickerField extends StatelessWidget {
  final String label;
  final String? hint;
  final Color borderColor;
  final List<String> attachedFiles;
  final void Function(List<String>) onFilesChanged;
  final void Function(int) onRemoveFile; // Nuevo callback para eliminar archivos

  const FilePickerField({
    super.key,
    required this.label,
    this.hint,
    this.borderColor = Colors.black45,
    required this.attachedFiles,
    required this.onFilesChanged,
    required this.onRemoveFile, // Requerido ahora
  });

  @override
  Widget build(BuildContext context) {
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
                if (attachedFiles.isNotEmpty)
                  Column(
                    children: attachedFiles.map((filePath) {
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          path.basename(filePath),
                          style: const TextStyle(fontSize: 14),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.clear, color: Colors.red),
                          onPressed: () {
                            final index = attachedFiles.indexOf(filePath);
                            onRemoveFile(index); // Invocamos el callback para eliminar
                          },
                        ),
                      );
                    }).toList(),
                  ),
                if (attachedFiles.isEmpty && hint != null)
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
                  child: ElevatedButton(
                    onPressed: () async {
                      final result = await FilePicker.platform.pickFiles(allowMultiple: true);
                      if (result != null) {
                        final newFiles = result.paths.whereType<String>().toList();
                        onFilesChanged([...attachedFiles, ...newFiles]);
                      }
                    },
                    child: const Text('+ Añadir documentos'),
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