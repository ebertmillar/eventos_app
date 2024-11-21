
import 'package:eventos_app/features/auth/domain/entities/user.dart';

abstract class AuthDatasource {

  Future <User> login(String email, String password);

  Future<User> register(
    String fullName,
    String companyName,
    String nif,
    String email,
    String telefono,
    String sector,
    bool aceptaTerminos,
    bool aceptaComunicaciones,

  );

  Future <User> checkAuthStatus(String token);


}