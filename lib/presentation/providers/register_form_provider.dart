//! state provider

import 'package:country_code_picker/country_code_picker.dart';
import 'package:eventos_app/presentation/providers/auth_provider.dart';
import 'package:eventos_app/presentation/shared/infrastucture/inputs/sector.dart';
import 'package:eventos_app/presentation/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';

final registerFormProvider = StateNotifierProvider<RegisterFormNotifier,RegisterFormState>((ref) {

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
      isValid: Formz.validate([newFullName, state.companyName, state.nif, state.email, state.telefono ])
    );
  }

  void onCompanyNameChanged(String value) {
    final newCompanyName = CompanyName.dirty(value: value);
    state = state.copyWith(
      companyName: newCompanyName,
      isValid: Formz.validate([newCompanyName, state.fullName, state.nif, state.email, state.telefono])
    );
  }

  void onNifChanged(String value) {
    final newNif = NifNie.dirty(value: value);
    state = state.copyWith(
      nif: newNif,
      isValid: Formz.validate([newNif, state.fullName, state.nif, state.email, state.telefono])
    );
  }

  void onEmailChanged(String value) {
    final newEmail = Email.dirty(value: value);
    state = state.copyWith(
      email: newEmail,
      isValid: Formz.validate([newEmail, state.fullName, state.companyName, state.nif, state.telefono]),
    );
  }

  void onTelefonoChanged(String value) {
    //state = state.copyWith(telefono: value);
    final newTelefono = Phone.dirty(value: value);
    state = state.copyWith(
      telefono: newTelefono,
      isValid: Formz.validate([newTelefono, state.fullName, state.companyName, state.nif, state.email, state.sector])
    );
  }

void onPrefixChanged(CountryCode country) {
  state = state.copyWith(selectedPrefix: country.dialCode);
}

  void onSectorChanged(String value) {
    final newSector = Sector.dirty(value: value);
    state = state.copyWith(
      sector: newSector,
      isValid: Formz.validate([newSector, state.fullName, state.companyName, state.nif, state.email, state.telefono])
    );
  }

  void onAceptaTerminosChanged(bool value) {
    state = state.copyWith(aceptaTerminos: value);
  }

  void onAceptaComunicacionesChanged(bool value) {
    state = state.copyWith(aceptaComunicaciones: value);
  }



  onFormSubmit(BuildContext context ) async {
    _touchEveryField();

    if (!state.aceptaTerminos) {
      showTermsDialog(context);
      return; 
    }

    if(!state.isValid) return;

    state = state.copyWith(isPosting: true);


    // Combina prefijo y teléfono
    final fullPhoneNumber = '${state.selectedPrefix}${state.telefono.value}';

    await registerUserCallback(
      state.fullName.value, 
      state.companyName.value, 
      state.nif.value, 
      state.email.value, 
      fullPhoneNumber,
      state.sector.value, 
      state.aceptaTerminos, 
      state.aceptaComunicaciones ?? false
    );

    state = state.copyWith(isPosting: false);


  }

  _touchEveryField() {
    final email = Email.dirty(value: state.email.value);
    final fullName = FullName.dirty(value: state.fullName.value);
    final companyName = CompanyName.dirty(value: state.companyName.value);
    final nif = NifNie.dirty(value: state.nif.value);
    final telefono = Phone.dirty(value: state.telefono.value);
    final sector = Sector.dirty(value: state.sector.value);
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
      isValid: Formz.validate([fullName,companyName, nif, email, telefono]), // Actualiza si es necesario
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
  final String selectedPrefix;
  final Sector sector;
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
    this.telefono = const Phone.pure(),
    this.selectedPrefix = '+34', 
    this.sector = const Sector.pure(), 
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
    String? selectedPrefix,
    Sector? sector,
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
    selectedPrefix: selectedPrefix ?? this.selectedPrefix,
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

void showTermsDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false, 
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Términos y Condiciones'),
        content: const Text('Debe aceptar los términos y condiciones para continuar.'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); 
            },
            child: const Text('Cerrar'),
          ),
        ],
      );
    },
  );
}