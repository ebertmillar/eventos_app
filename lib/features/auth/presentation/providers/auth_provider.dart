
import 'package:eventos_app/features/auth/domain/domain.dart';
import 'package:eventos_app/features/auth/infrastructure/infrastructure.dart';
import 'package:eventos_app/shared/shared.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter_riverpod/flutter_riverpod.dart';


final authProvider =  StateNotifierProvider<AuthNotifier, AuthProvider>((ref) {

  final authRepository = AuthRepositoryImpl();
  final keyValueStorage = KeyValueServiceImpl();
  

  return AuthNotifier(
    authRepository: authRepository,
    keyValueStorage: keyValueStorage,
  );

});


class AuthNotifier extends StateNotifier<AuthProvider> {

  final AuthRepository authRepository;
  final KeyValueStorage keyValueStorage;

  AuthNotifier({
    required this.authRepository,
    required this.keyValueStorage,
  }): super(AuthProvider());

  void loginUser(String email, String password) async{
    
    // void loginUser(String email, String password) async{
    // final user = await authRepository.login(email, password);
    // state = state.copyWith();

  }

  Future<void> registerUser(
    String fullName, 
    String companyName, 
    String nif, 
    String email,
    String telefono, 
    String sector, 
    bool aceptaTerminos, 
    bool aceptaComunicaciones) async {

      await  Future.delayed(const Duration(milliseconds: 500));
      
      try {
        
        final user = await authRepository.register(
          fullName, companyName, nif, email, telefono, sector, aceptaTerminos, aceptaComunicaciones);

          _setLoggedUser(user);

      } on WrongCredentials catch (e) {
            logout(e.message);  
          } on InvalidToken catch (e) {
            logout(e.message);  
          } on ConnectionTimeout catch (e) {
            logout(e.message);  
          } catch (e) {
            logout(e.toString());  // Llamar a logout con un mensaje genérico de error
          }
        
  }


  void checkAuthStatus() async {
    final token = await keyValueStorage.getValue<String>('token');
    print('Token recuperado en checkAuthStatus: $token');

    if (token == null || token.isEmpty) {
      print('Token no encontrado. Desconectando al usuario.');
      return logout();
    }

    try {
      final currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser == null) {
        print('El usuario no está autenticado. Verifica el token.');
        return logout();
      }

      final idToken = await currentUser.getIdToken(true);
        print('Token renovado al verificar estado: $idToken');
      // Imprimir el email del usuario autenticado
        print('Usuario autenticado:');
        print('Email: ${currentUser.email}');
        print('Token renovado al verificar estado: $idToken');

      // Actualizar estado
      state = state.copyWith(
        authStatus: AuthStatus.authenticated,
        idToken: idToken,
        currentUserId: currentUser.uid, 
      );
    } catch (e) {
      print('Error al verificar el estado de autenticación: $e');
      logout();
    }
  }


  void _setLoggedUser(User user) async {
    // Primero autenticar al usuario con el customToken
    await FirebaseAuth.instance.signInWithCustomToken(user.token);

   // Luego obtener el idToken
    final idToken = await FirebaseAuth.instance.currentUser?.getIdToken() ?? '';

    if (idToken.isEmpty) {
      throw CustomError('Error: El ID token no se pudo generar.');
    }

     // Guardar el idToken en SharedPreferences
    await keyValueStorage.setKeyValue('token', idToken);
    print('Usuario autenticado:');
    print('Email: ${user.email}');
    print('ID Token: $idToken');

    state = state.copyWith(
      user: user,
      authStatus: AuthStatus.authenticated,
      idToken: idToken,
      currentUserId: user.id,
      errorMessage: '',
    );
  }

  Future<String> getIdToken(String customToken) async {
    try {
      final userCredential =
          await FirebaseAuth.instance.signInWithCustomToken(customToken);
      print("Sign-in successful.");

      final idToken = await userCredential.user?.getIdToken(true) ?? '';
      if (idToken.isEmpty) {
        throw CustomError("No se pudo obtener el ID token.");
      }
      return idToken;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "invalid-custom-token":
          print("El token proporcionado no es un token de autenticación personalizado válido.");
          break;
        case "custom-token-mismatch":
          print("El token proporcionado es para un proyecto Firebase diferente.");
          break;
        default:
          print("Error desconocido en la autenticación.");
      }
      throw CustomError("Error de autenticación: ${e.message}");
    } catch (e) {
      throw CustomError('Error al obtener el ID token: $e');
    }
  }

  Future<void> logout([String? errorMessage]) async{
    //Remover token 
    await keyValueStorage.removeKey('token');

    state = state.copyWith(
      authStatus: AuthStatus.notAuthenticated,
      user: null,
      errorMessage: errorMessage,
      currentUserId: null,
    );

  }

}
  

enum AuthStatus{ checking, authenticated, notAuthenticated}

class AuthProvider {

  final AuthStatus authStatus;
  final User? user;
  final String errorMessage;
  final String idToken;
  final String? currentUserId;

  AuthProvider({
    this.authStatus = AuthStatus.checking, 
    this.user, 
    this.errorMessage ='',
    this.idToken='',
    this.currentUserId,  
    });

  AuthProvider copyWith({
    AuthStatus? authStatus,
    User? user,
    String? errorMessage,
    String? idToken,
    String? currentUserId,
  }) => AuthProvider(
    authStatus: authStatus ?? this.authStatus,
    user: user ?? this.user,
    errorMessage: errorMessage ?? this.errorMessage,
    idToken: idToken ?? this.idToken,
    currentUserId: currentUserId ?? this.currentUserId,
  );
  


}