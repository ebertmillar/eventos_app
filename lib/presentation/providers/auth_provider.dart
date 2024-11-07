
import 'package:eventos_app/domain/domain.dart';
import 'package:eventos_app/infrastructure/infrastructure.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final authProvider =  StateNotifierProvider<AuthNotifier, AuthProvider>((ref) {

  final authRepository = AuthRepositoryImpl();

  return AuthNotifier(authRepository: authRepository);

});


class AuthNotifier extends StateNotifier<AuthProvider> {

  final AuthRepository authRepository; 

  AuthNotifier({
    required this.authRepository
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
            logout('Error desconocido: ${e.toString()}');  // Llamar a logout con un mensaje genérico de error
          }
        
  }


  void checkAuthStatus() async {
    
  }

  void _setLoggedUser (User user){
    //guardar token fisicamente
    state = state.copyWith(
    user: user,
    authStatus: AuthStatus.authenticated,
    );
  }

  Future<void> logout([String? errorMessage]) async{

  state = state.copyWith(
    authStatus: AuthStatus.notAuthenticated,
    user: null,
    errorMessage: errorMessage,
  );



}





    
    

  }
  



enum AuthStatus{ checking, authenticated, notAuthenticated}

class AuthProvider {

  final AuthStatus authStatus;
  final User? user;
  final String errorMessage;

  AuthProvider({
    this.authStatus = AuthStatus.checking, 
    this.user, 
    this.errorMessage ='',
    });

  AuthProvider copyWith({
    AuthStatus? authStatus,
    User? user,
    String? errorMessage,
  }) => AuthProvider(
    authStatus: authStatus ?? this.authStatus,
    user: user ?? this.user,
    errorMessage: errorMessage ?? this.errorMessage,
  );
  


}