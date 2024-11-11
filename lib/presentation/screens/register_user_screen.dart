import 'package:country_code_picker/country_code_picker.dart';
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
    // Agrega una variable para almacenar el prefijo seleccionado

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

          // CustomFormFieldNumber(
          //   initialValue: PhoneNumber(isoCode: 'ES', dialCode: '+34'),
          //   label: 'numero'),
          
          // //Numero de telefono y prefijo
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
                            closeIcon: Icon(Icons.close, size: 24),
                            margin: EdgeInsets.only(right: 4, left: 0),
                            onChanged: (country) {
                              //ref.read(registerFormProvider.notifier).onPrefixChanged(country.toString());
                              ref.read(registerFormProvider.notifier).onPrefixChanged(country);
                            },
                            
                          ),
                          Icon(Icons.arrow_drop_down, size: 20,)
                        
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

                    
          // Sector Field (Custom Dropdown)
          CustomDropdownFormField(
            label: 'Sector',
            hint: 'Introduce el sector al que te dedicas',
            items: sectorOptions,
            selectedValue: selectedSector,
            onChanged: (String? newValue) {
              ref.read(registerFormProvider.notifier).onSectorChanged(newValue ?? '');
            },
            errorMessage: registerForm.isFormPosted ? registerForm.sector.errorMessage : null,
          ),
                  
          const SizedBox(height: 5),

          CustomCheckBox(
            label: 'Acepto los términos y condiciones',
            value: ref.watch(registerFormProvider).aceptaTerminos,
            onChanged: (newValue) {
              ref.read(registerFormProvider.notifier).onAceptaTerminosChanged(newValue ?? false);
            },
          ),
          // Usando CustomCheckBox para "Acepto condiciones comerciales"
          CustomCheckBox(
            label: 'Acepto condiciones comerciales',
            value: ref.watch(registerFormProvider).aceptaComunicaciones ?? false,
            onChanged: (newValue) {
              ref.read(registerFormProvider.notifier).onAceptaComunicacionesChanged(newValue ?? false);
            },
          ),
                   
          const SizedBox(height:15),

          CustomFilledButton(
            onPressed: (){
              ref.read(registerFormProvider.notifier).onFormSubmit(context);

            },
                
            text: 'Crear cuenta',
            textColor: Colors.amber,
            
          ), 

          const SizedBox(height:15),        
        ],      
      )

    
    );
  }
}
