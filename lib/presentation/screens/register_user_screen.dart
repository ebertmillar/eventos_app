import 'package:country_code_picker/country_code_picker.dart';
import 'package:eventos_app/presentation/providers/auth_provider.dart';
import 'package:eventos_app/presentation/providers/register_form_provider.dart';
import 'package:eventos_app/presentation/shared/widgets/custom_checkbox.dart';
import 'package:eventos_app/presentation/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class RegisterUserScreen extends StatelessWidget {
  const RegisterUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    return const Scaffold(
      appBar: CustomAppbar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: 
                Text(
                  'Primero,',
                  style: TextStyle(fontSize: 25), 
                ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Text(
                'Creamos una cuenta',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold), 
                              ),
            ),

            SizedBox(height: 5),

            SizedBox(
              width: double.infinity,
              child: const _RegisterForm(),
            ),

          ],
        ),
      ),
      bottomNavigationBar: CustomNavigationbar(),
    
    );
  }
}


class _RegisterForm extends ConsumerWidget {
  const _RegisterForm();

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final registerForm = ref.watch(registerFormProvider);

    ref.listen(authProvider, (previous, next){

      if(next.errorMessage.isEmpty) return;

      showSnackbar( context, next.errorMessage);

    });

    String? selectedSector;
      
      final List<String> sectorOptions = [
        'Tecnología',
        'Educación',
        'Salud',
        'Finanzas',
        'Comercio',
        'Manufactura',
      ];      

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        children: [
          
          CustomTextFormField(
            label: 'Nombre completo', 
            hint: 'Tu nombre completo',
            keyboardType: TextInputType.text,
            onChanged: ref.read(registerFormProvider.notifier).onFullNameChanged,
            errorMessage: registerForm.isFormPosted ? registerForm.fullName.errorMessage : null,             
          ),
                    
          CustomTextFormField(
            label: 'Nombre de la empresa', 
            hint: 'El nombre de la empresa',
            keyboardType: TextInputType.text,
            onChanged: ref.read(registerFormProvider.notifier).onCompanyNameChanged,    
            errorMessage: registerForm.isFormPosted ? registerForm.companyName.errorMessage : null,             
          ),
          
          CustomTextFormField(
            label: 'NIF/NIE', 
            hint: 'Tu NIE o NIF de la empresa',
            keyboardType: TextInputType.text,
            onChanged: ref.read(registerFormProvider.notifier).onNifChanged,
            errorMessage: registerForm.isFormPosted ? registerForm.nif.errorMessage : null,    
          ),
          
          CustomTextFormField(
            label: 'Email', 
            hint: 'Correo Electrónico',
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) => ref.read(registerFormProvider.notifier).onEmailChanged(value),
            errorMessage: registerForm.isFormPosted ? registerForm.email.errorMessage : null,
          ),

          Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    height: 56,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                          
                          CountryCodePicker(
                            padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 0),
                            
                            initialSelection: 'ES',
                            textOverflow: TextOverflow.visible,
                            flagWidth: 23,
                            closeIcon: const Icon(Icons.close, size: 2),
                            margin: const EdgeInsets.only(right: 4, left: 0),
                            onChanged: (country) {
                              ref.read(registerFormProvider.notifier).onPrefixChanged(country);
                            },
                            
                          ),
                          const Icon(Icons.arrow_drop_down, size: 20,)
                        
                      ],
                    ),
                ),
              ),

              const SizedBox(width: 10),

              Expanded(
                flex: 2,
                
                child: CustomTextFormField(
                  onChanged: (value) => ref.read(registerFormProvider.notifier).onTelefonoChanged(value),
                  keyboardType: TextInputType.phone,
                  label: 'Teléfono', 
                  hint: '555 555 555',
                  errorMessage: registerForm.isFormPosted ? registerForm.telefono.errorMessage : null,
                ),
               
              ),              
            ],
          ),

          CustomDropdownFormField(
            label: 'Sector',
            hint: 'Selecciona el sector al que te dedicas',
            items: sectorOptions,
            selectedValue: selectedSector,
            onChanged: (String? newValue) {
              ref.read(registerFormProvider.notifier).onSectorChanged(newValue ?? '');
            },
            errorMessage: registerForm.isFormPosted ? registerForm.sector.errorMessage : null,
          ),
                  
          const SizedBox(height: 5),

          CustomCheckBox(
            contentPadding: const EdgeInsets.symmetric(horizontal: 50),
            label: 'Acepto los términos y condiciones',
            value: ref.watch(registerFormProvider).aceptaTerminos,
            onChanged: (newValue) {
              ref.read(registerFormProvider.notifier).onAceptaTerminosChanged(newValue ?? false);
            },
          ),

          CustomCheckBox(
            label: 'Acepto condiciones comerciales',
            contentPadding: const EdgeInsets.symmetric(horizontal: 50),
            value: ref.watch(registerFormProvider).aceptaComunicaciones ?? false,
            onChanged: (newValue) {
              ref.read(registerFormProvider.notifier).onAceptaComunicacionesChanged(newValue ?? false);
            },
          ),
                   
          const SizedBox(height:15),

          CustomFilledButton(
            onPressed: registerForm.isPosting 
              ? null
              : () => ref.read(registerFormProvider.notifier).onFormSubmit(context),
                  text: registerForm.isPosting ? null : 'Crear cuenta',
                  child: registerForm.isPosting 
              ? const SizedBox(
                  width: 24.0,  // Ajusta el ancho del círculo
                  height: 24.0, // Ajusta el alto del círculo
                  child: CircularProgressIndicator(
                    color: Colors.amber,
                    strokeWidth: 2, // Ajusta el grosor del borde
                  ),
                )
              : const Text('Crear cuenta', style: TextStyle(color: Colors.amber)),
            
          ), 

          const SizedBox(height:15),        
        ],      
      )

    
    );
  }
  
  void showSnackbar(BuildContext context, String errorMessage) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(errorMessage)
      )
    );
  }
  
}
