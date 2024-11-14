import 'package:eventos_app/domain/entities/user.dart';

class UserMapper {
  
  static User userJsonToEntity(Map<String, dynamic> json) {
    // Mapear solo los campos presentes en la respuesta del servidor
    return User(
      id: json["uid"] ?? '', // Asume que `uid` es el `id` esperado
      email: json["email"] ?? '',
      roles: json.containsKey("roles") ? List<String>.from(json["roles"]) : [],
      // Valores predeterminados para los campos faltantes
      fullName: json["fullName"] ?? '',
      companyName: json["companyName"] ?? '',
      nif: json["nif"] ?? '',
      telefono: json["telefono"] ?? '',
      sector: json["sector"] ?? '',
      isActive: json["isActive"] ?? false,
      aceptaTerminos: json["aceptaTerminos"] ?? false,
      aceptaComunicaciones: json["aceptaComunicaciones"] ?? false,
      token: json["token"] ?? '',
    );
  }

  // Mapea la respuesta de check-status con los campos que están presentes
  static User userJsonToEntityCheckStatus(Map<String, dynamic> json) {
    return User(
      id: json["uid"] ?? '',  // Mapea `uid` a `id`
      email: json["email"] ?? '',
      roles: json.containsKey("roles") ? List<String>.from(json["roles"]) : [],
      // Valores predeterminados para campos opcionales
      fullName: '',
      companyName: '',
      nif: '',
      telefono: '',
      sector: '',
      isActive: true,  // Asume que el usuario está activo si está autenticado
      aceptaTerminos: false,
      aceptaComunicaciones: false,
      token: '', // Puedes dejar el token vacío si no lo necesitas en esta respuesta
    );
  }
}