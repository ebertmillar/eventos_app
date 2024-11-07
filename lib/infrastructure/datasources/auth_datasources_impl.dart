import 'package:dio/dio.dart';
import 'package:eventos_app/config/config.dart';
import 'package:eventos_app/domain/domain.dart';
import 'package:eventos_app/infrastructure/errors/register_errors.dart';
import 'package:eventos_app/infrastructure/infrastructure.dart';

class AuthDatasourcesImpl extends AuthDatasource {
  final dio = Dio(BaseOptions(
    baseUrl: Environment.apiUrl,
  ));

  @override
  Future<User> checkAuthStatus(String token) {
    // TODO: implement checkAuthStatus
    throw UnimplementedError();
  }

  @override
  Future<User> login(String email, String password) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<User> register(
      String fullName,
      String companyName,
      String nif,
      String email,
      String telefono,
      String sector,
      bool aceptaTerminos,
      bool aceptaComunicaciones) async {
    try {
      final response = await dio.post('/auth/register', data: {
        'fullName': fullName,
        'companyName': companyName,
        'nif': nif,
        'email': email,
        'telefono': telefono,
        'sector': sector,
        'aceptaTerminos': aceptaTerminos,
        'aceptaComunicaciones': aceptaComunicaciones
      });

      final user = UserMapper.userJsonToEntity(response.data);
      return user;

    } catch (e) {
      throw WrongCredentials();
    }

  }
}
