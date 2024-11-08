//! state provider

import 'package:eventos_app/presentation/providers/auth_provider.dart';
import 'package:eventos_app/presentation/shared/infrastucture/inputs/phone.dart';
import 'package:eventos_app/presentation/shared/shared.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

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
    final newFullName = FullName.dirty(value: value);
    state = state.copyWith(
      fullName: newFullName,
      isValid: Formz.validate([newFullName, state.companyName, state.nif, state.email])
    );
  }

  void onCompanyNameChanged(String value) {
    final newCompanyName = CompanyName.dirty(value: value);
    state = state.copyWith(
      companyName: newCompanyName,
      isValid: Formz.validate([newCompanyName, state.fullName, state.nif, state.email])
    );
  }

  void onNifChanged(String value) {
    final newNif = NifNie.dirty(value: value);
    state = state.copyWith(
      nif: newNif,
      isValid: Formz.validate([newNif, state.fullName, state.nif, state.email])
    );
  }

  void onEmailChanged(String value) {
    final newEmail = Email.dirty(value: value);
    state = state.copyWith(
      email: newEmail,
      isValid: Formz.validate([newEmail, state.fullName, state.companyName, state.nif]),
    );
  }

  void onTelefonoChanged(String value) {
    //state = state.copyWith(telefono: value);
    final newTelefono = Phone.dirty(value: value);
    state = state.copyWith(
      telefono: newTelefono,
      isValid: Formz.validate([newTelefono, state.fullName, state.companyName, state.nif, state.email])
    );
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
    state.fullName.value, 
    state.companyName.value, 
    state.nif.value, 
    state.email.value, 
    state.telefono.value,
    state.sector, 
    state.aceptaTerminos, 
    state.aceptaComunicaciones ?? false
  );

    print(state);


  }

  _touchEveryField() {
    final email = Email.dirty(value: state.email.value);
    final fullName = FullName.dirty(value: state.fullName.value);
    final companyName = CompanyName.dirty(value: state.companyName.value);
    final nif = NifNie.dirty(value: state.nif.value);
    final telefono = Phone.dirty(value: state.telefono.value);
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
      isValid: Formz.validate([email , nif]),
    );
  }
  
}


class RegisterFormState{
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final FullName fullName;
  final CompanyName companyName;
  final NifNie nif;
  final Email email;
  final Phone telefono;
  final String sector;
  final bool aceptaTerminos;
  final bool? aceptaComunicaciones;

  RegisterFormState({
    this.isPosting = false, 
    this.isFormPosted= false, 
    this.isValid = false, 
    this.fullName = const FullName.pure(), 
    this.companyName = const CompanyName.pure(), 
    this.nif = const NifNie.pure(), 
    this.email = const Email.pure(), 
    this.telefono = const Phone.pure() , 
    this.sector ='', 
    this.aceptaTerminos = false, 
    this.aceptaComunicaciones = false
  });

  RegisterFormState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    FullName? fullName,
    CompanyName? companyName,
    NifNie? nif,
    Email? email,
    Phone? telefono,
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

