import 'package:eventos_app/domain/entities/user.dart';

class UserMapper {
  
  static userJsonToEntity(Map<String, dynamic> json) => User(
    id: json["id"],
    fullName: json["fullName"],
    companyName: json["companyName"],
    nif: json["nif"],
    email: json["email"],
    telefono: json["telefono"],
    sector: json["sector"],
    isActive: json["isActive"],
    aceptaTerminos: json["aceptaTerminos"],
    aceptaComunicaciones: json["aceptaComunicaciones"] ?? false,
    roles: List<String>.from(json["roles"].map((role) => role)),
    token: json["token"],
  );
}