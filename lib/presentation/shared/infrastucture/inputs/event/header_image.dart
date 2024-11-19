import 'dart:io';
import 'package:formz/formz.dart';

// Definir los errores de validación
enum HeaderImageError { empty }

class HeaderImage extends FormzInput<File?, HeaderImageError> {
  const HeaderImage.pure() : super.pure(null);
  const HeaderImage.dirty({required File? value}) : super.dirty(value);

  @override
  HeaderImageError? validator(File? value) {
    if (value == null || value.path.isEmpty) return HeaderImageError.empty;
    return null;
  }

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == HeaderImageError.empty) {
      return 'Debes seleccionar una imagen para promocionar tu evento';
    }

    return null;
  }
}


  