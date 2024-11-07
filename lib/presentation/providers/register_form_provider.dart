//! state provider

import 'package:eventos_app/presentation/shared/infrastucture/inputs/email.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';

final registerFormProvider = StateNotifierProvider.autoDispose<RegisterFormNotifier,RegisterFormState>((ref) {
  return RegisterFormNotifier();
});


class RegisterFormNotifier extends StateNotifier<RegisterFormState> {
  RegisterFormNotifier(): super(RegisterFormState());

  void onEmailChanged(String value) {
    final newEmail = Email.dirty(value: value);
    state = state.copyWith(
      email: newEmail,
      isValid: Formz.validate([newEmail]),
    );
  }

  onFormSubmit(){
    _touchEveryField();

    if(!state.isValid) return;

    print(state);


  }

  _touchEveryField() {
    final email = Email.dirty(value: state.email.value);

    state = state.copyWith(
      isFormPosted: true,
      email: email,
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

