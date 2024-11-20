import 'package:eventos_app/presentation/providers/create_event_form_provider.dart';
import 'package:eventos_app/presentation/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DatosContactoScreen extends ConsumerWidget{
  const DatosContactoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final eventFormNotifier = ref.read(createEventFormProvider.notifier);
    final eventFormState = ref.watch(createEventFormProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Datos de Contacto',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),

        CustomTextFormField(
          label: 'Organizador',
          hint: 'Nombre del organizador o empresa',
          keyboardType: TextInputType.text,
          errorMessage: eventFormState.contactName.errorMessage,
          controller: eventFormNotifier.contactNameController,
          onChanged: eventFormNotifier.onContactNameChanged,

        ),
        
        CustomTextFormField(  
          label: 'Email',
          hint: 'Email del responsable del evento',
          keyboardType: TextInputType.text,
          errorMessage: eventFormState.contactEmail.errorMessage,
          controller: eventFormNotifier.contactEmailController,
          onChanged: eventFormNotifier.onContactEmailChanged,
        ),
        CustomTextFormField(
          label: 'Teléfono de contacto',
          hint: 'Teléfono del responsable del evento',
          keyboardType: TextInputType.text,
          errorMessage: eventFormState.contactPhone.errorMessage,
          controller: eventFormNotifier.contactPhoneController,
          onChanged: eventFormNotifier.onContactPhoneChanged,
        ),
        CustomTextFormField(
          label: 'Página web',
          hint: 'Añade URL del evento',
          keyboardType: TextInputType.text,
          errorMessage: eventFormState.webpage?.errorMessage ,
          controller: eventFormNotifier.webpageController,
          onChanged: eventFormNotifier.onWebpageChanged,
          
        ),
        CustomTextFormField(
          label: '¿Tienes Instagram?',
          hint: 'Añade tu @user o URL',
          keyboardType: TextInputType.text,
          errorMessage: eventFormState.instagram?.errorMessage ,
          controller: eventFormNotifier.instagramController,
          onChanged: eventFormNotifier.onInstagramChanged,
        ),
        CustomTextFormField(
          label: '¿Tienes Facebook?',
          hint: 'Añade tu @user o URL',
          keyboardType: TextInputType.text,
          errorMessage: eventFormState.facebook?.errorMessage ,
          controller: eventFormNotifier.facebookController,
          onChanged: eventFormNotifier.onFacebookChanged,
        ),
        CustomTextFormField(
          label: '¿Tienes Youtube?',
          hint: 'Añade tu @user o URL',
          keyboardType: TextInputType.text,
          errorMessage: eventFormState.youtube?.errorMessage ,
          controller: eventFormNotifier.youtubeController,
          onChanged: eventFormNotifier.onYouTubeChanged,
        ),
        CustomTextFormField(
          label: '¿Tienes Linkedin?',
          hint: 'Añade tu @user o URL',
          keyboardType: TextInputType.text,
          errorMessage: eventFormState.linkedin?.errorMessage ,
          controller: eventFormNotifier.linkedinController,
          onChanged: eventFormNotifier.onLinkedInChanged,
        ),



      ],
    );
  }
}
