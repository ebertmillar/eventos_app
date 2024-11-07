import 'package:eventos_app/presentation/widgets/shared/custom_checkbox.dart';
import 'package:eventos_app/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

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

class _RegisterForm extends StatefulWidget {
  const _RegisterForm();

  @override
  State<_RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<_RegisterForm> {

  bool isCheckedTerminos = false; // Estado para "Acepto los términos"
  bool isCheckedComunicaciones = false; // Estado para "Acepto condiciones comerciales"

  String? selectedSector;
    
    final List<String> sectorOptions = [
      'Tecnología',
      'Educación',
      'Salud',
      'Finanzas',
      'Comercio',
      'Manufactura',
    ];      

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        children: [
          
          CustomTextFormField(
            label: 'Nombre completo', 
            hint: 'Tu nombre completo',
            
          ),
                    
          CustomTextFormField(
            label: 'Nombre de la empresa', 
            hint: 'El nombre de la empresa',
           
           
          ),
          
          CustomTextFormField(
            label: 'NIF/NIE', 
            hint: 'Tu NIE o NIF de la empresa',
            
          ),
          
          CustomTextFormField(
            label: 'Email', 
            hint: 'Correo Electrónico',
          ),
          
          //Numero de telefono y prefijo
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    height: 56,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.flag, size: 18),
                        SizedBox(width: 5),
                        Text('+34', style: TextStyle(fontSize: 14)), // Country code example
                      ],
                    ),
                ),
              ),

              const SizedBox(width: 10),

              Expanded(
                flex: 2,
                child: CustomTextFormField(
                  label: 'Teléfono', 
                  hint: '555 555 555'),
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
            },
                  ),
                  
          const SizedBox(height: 5),

          CustomCheckBox(
            label: 'Acepto los términos y condiciones',
            value: isCheckedTerminos,
            onChanged: (newValue) {
              setState(() {
                isCheckedTerminos = newValue!;
              });
            },
          ),
          // Usando CustomCheckBox para "Acepto condiciones comerciales"
          CustomCheckBox(
            label: 'Acepto condiciones comerciales',
            value: isCheckedComunicaciones,
            onChanged: (newValue) {
              setState(() {
                isCheckedComunicaciones = newValue!;
              });
            },
          ),
                   
          const SizedBox(height:15),

          CustomFilledButton(
            onPressed: (){},
                
            text: 'Crear cuenta',
            textColor: Colors.amber,
            
          ), 

          const SizedBox(height:15),        
        ],      
      )

    
    );
  }
}
