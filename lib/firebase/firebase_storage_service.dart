import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

Future<String?> uploadImageAndGetUrl(String localImagePath) async {
  try {
    // Convertir la ruta local a archivo
    final file = File(localImagePath);

    // Verificar si el archivo existe
    if (!file.existsSync()) {
      print("El archivo no existe en la ruta local: $localImagePath");
      return null;  // Retorna null si el archivo no existe
    }

    // Subir la imagen a Firebase Storage
    final uploadTask = FirebaseStorage.instance
        .ref('Images/${localImagePath.split('/').last}')
        .putFile(file);

    // Esperar que la tarea de subida se complete
    final snapshot = await uploadTask;

    // Obtener la URL de la imagen
    final imageUrl = await snapshot.ref.getDownloadURL();

    print("URL de la imagen subida: $imageUrl");
    return imageUrl;  // Retorna la URL de la imagen
  } catch (e) {
    print("Error al subir la imagen: $e");
    return null;  // Si hay error, retornamos null
  }
}



Future<List<String>> uploadDocumentsToStorage(List<String>? filePaths) async {
  if (filePaths == null || filePaths.isEmpty) {
    print("No hay documentos para subir.");
    return [];
  }

  List<String> urls = [];
  for (final filePath in filePaths) {
    // Verificar si ya es una URL de Firebase
    if (filePath.startsWith('https://firebasestorage.googleapis.com')) {
      urls.add(filePath); // Ya es una URL válida
      continue;
    }

    // Verificar si el archivo existe localmente
    final file = File(filePath);
    if (!file.existsSync()) {
      print("El archivo no existe: $filePath");
      continue;
    }

    // Subir archivo a Firebase Storage
    try {
      final fileName = filePath.split('/').last; // Obtener el nombre del archivo
      final ref = FirebaseStorage.instance.ref().child("Documents/$fileName");

      final uploadTask = ref.putFile(file);
      final snapshot = await uploadTask;
      final downloadUrl = await snapshot.ref.getDownloadURL();
      urls.add(downloadUrl);
    } catch (e) {
      print("Error al subir el archivo $filePath: $e");
    }
  }

  return urls;
}



