//! state provider

import 'package:eventos_app/presentation/providers/auth_provider.dart';
import 'package:eventos_app/presentation/shared/infrastucture/inputs/email.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';

final registerFormProvider = StateNotifierProvider.autoDispose<RegisterFormNotifier,RegisterFormState>((ref) {

  final registerUserCallback = ref.watch(authProvider.notifier).registerUser;

  return RegisterFormNotifier(registerUserCallback: registerUserCallback);
});


class RegisterFormNotifier extends StateNotifier<RegisterFormState> {

  final Function(String, String, String, String, String, String, bool, bool) registerUserCallback;

  RegisterFormNotifier({
    required this.registerUserCallback
  }): super(RegisterFormState());

  void onFullNameChanged(String value) {
    state = state.copyWith(fullName: value);
  }

  void onCompanyNameChanged(String value) {
    state = state.copyWith(companyName: value);
  }

  void onNifChanged(String value) {
    state = state.copyWith(nif: value);
  }

  void onEmailChanged(String value) {
    final newEmail = Email.dirty(value: value);
    state = state.copyWith(
      email: newEmail,
      isValid: Formz.validate([newEmail]),
    );
  }

  void onTelefonoChanged(String value) {
    state = state.copyWith(telefono: value);
  }

  void onSectorChanged(String value) {
    state = state.copyWith(sector: value);
  }

  void onAceptaTerminosChanged(bool value) {
    state = state.copyWith(aceptaTerminos: value);
  }

  void onAceptaComunicacionesChanged(bool value) {
    state = state.copyWith(aceptaComunicaciones: value);
  }



  onFormSubmit() async {
    _touchEveryField();

    if(!state.isValid) return;

    await registerUserCallback(
    state.fullName, 
    state.companyName, 
    state.nif, 
    state.email.value, 
    state.telefono, 
    state.sector, 
    state.aceptaTerminos, 
    state.aceptaComunicaciones ?? false
  );

    print(state);


  }

  _touchEveryField() {
    final email = Email.dirty(value: state.email.value);
    final fullName = state.fullName.isNotEmpty ? state.fullName : 'El campo es requerido';
    final companyName = state.companyName.isNotEmpty ? state.companyName : 'El campo es requerido';
    final nif = state.nif.isNotEmpty ? state.nif : 'El campo es requerido';
    final telefono = state.telefono.isNotEmpty ? state.telefono : 'El campo es requerido';
    final sector = state.sector.isNotEmpty ? state.sector : 'El campo es requerido';

    final aceptaTerminos = state.aceptaTerminos;
    final aceptaComunicaciones = state.aceptaComunicaciones ?? false; 
    

    state = state.copyWith(
      isFormPosted: true,
      fullName: fullName,
      companyName: companyName,
      nif: nif,
      email: email,
      telefono: telefono,
      sector: sector,
      aceptaTerminos: aceptaTerminos,
      aceptaComunicaciones: aceptaComunicaciones,
      isValid: Formz.validate([email]),
    );
  }
  
}


class RegisterFormState{
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final String fullName;
  final String companyName;
  final String nif;
  final Email email;
  final String telefono;
  final String sector;
  final bool aceptaTerminos;
  final bool? aceptaComunicaciones;

  RegisterFormState({
    this.isPosting = false, 
    this.isFormPosted= false, 
    this.isValid = false, 
    this.fullName = '', 
    this.companyName = '', 
    this.nif ='', 
    this.email = const Email.pure(), 
    this.telefono ='' , 
    this.sector ='', 
    this.aceptaTerminos = false, 
    this.aceptaComunicaciones = false
  });

  RegisterFormState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    String? fullName,
    String? companyName,
    String? nif,
    Email? email,
    String? telefono,
    String? sector,
    bool? aceptaTerminos,
    bool? aceptaComunicaciones,

  }) => RegisterFormState(
    isPosting: isPosting ?? this.isPosting,
    isFormPosted: isFormPosted ?? this.isFormPosted,
    isValid: isValid ?? this.isValid,
    fullName: fullName ?? this.fullName,
    companyName: companyName ?? this.companyName,
    nif: nif ?? this.nif,
    email: email ?? this.email,
    telefono: telefono ?? this.telefono,
    sector: sector ?? this.sector,
    aceptaTerminos: aceptaTerminos ?? this.aceptaTerminos,
    aceptaComunicaciones: aceptaComunicaciones ?? this.aceptaComunicaciones,

  );



  @override
  String toString() {
    return '''
      isPosting: $isPosting
      isFormPosted: $isFormPosted
      isValid: $isValid
      fullName: $fullName
      companyName: $companyName
      nif: $nif
      email: $email
      telefono: $telefono
      sector: $sector
      aceptaTerminos: $aceptaTerminos
      aceptaComunicaciones: $aceptaComunicaciones
    ''';
  }


}

