import 'package:eventos_app/features/auth/domain/domain.dart';
import 'package:eventos_app/features/auth/infrastructure/infrastructure.dart';



class AuthRepositoryImpl  extends AuthRepository{

  final AuthDatasource dataSource;

  AuthRepositoryImpl({
    AuthDatasource? dataSource
  }) : dataSource = dataSource ?? AuthDatasourcesImpl();

  @override
  Future<User> checkAuthStatus(String token) async {
    if (token.isEmpty) throw CustomError('Token vacío o inválido');

    return await dataSource.checkAuthStatus(token);
  }

  @override
  Future<User> login(String email, String password) {
    return dataSource.login(email, password);
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
    bool aceptaComunicaciones) {

    return dataSource.register(
      fullName, 
      companyName, 
      nif, 
      email, 
      telefono, 
      sector, 
      aceptaTerminos, 
      aceptaComunicaciones);
  }

}