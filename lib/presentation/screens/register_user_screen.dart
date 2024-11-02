import 'package:eventos_app/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

class RegisterUserScreen extends StatelessWidget {
  const RegisterUserScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;
    
    return Scaffold(
      appBar: const CustomAppbar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Text('Primero,', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Text('Creemos una cuenta', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 10),
            Container(
                    height: size.height - 125 , // 50 los dos sizebox + Text's appbar + bottomnav
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: scaffoldBackgroundColor,
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(100)),
                    ),
                    child: const _RegisterForm()
                  )
                  
          ]
        ),
      ),
      bottomNavigationBar: const CustomNavigationbar(),
    
    );
  }
  
 

}

class _RegisterForm extends StatelessWidget {
  const _RegisterForm();


  @override
  Widget build(BuildContext context) {    

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        children: [
          const CustomTextFormField(label: 'Nombre completo', hint: 'Tu nombre completo'),
          const SizedBox(height: 10),
          const CustomTextFormField(label: 'Nombre de la empresa', hint: 'El nombre de la empresa'),
          const SizedBox(height: 10),
          const CustomTextFormField(label: 'NIF/NIE', hint: 'Tu NIE o NIF de la empresa'),
          const SizedBox(height: 10),
          const CustomTextFormField(label: 'Email', hint: 'Correo Electrónico'),
          const SizedBox(height: 10),
          const CustomTextFormField(label: 'Teléfono', hint: '555 555 555',),
          const SizedBox(height: 10),
          const CustomSectorFormField(label:'Sector', items: ['secto1' , 'sector2'],),
          const SizedBox(height: 10),
       
          Column(mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              CheckboxListTile(
                value: true,
                onChanged: (value) {
                  // Lógica para el checkbox
                },
                title: const Text('Acepto los términos y condiciones de uso', style: TextStyle(fontSize: 12),),
                dense: true, // Hace que el CheckboxListTile sea más compacto
                controlAffinity: ListTileControlAffinity.leading, // Alinea el checkbox a la izquierda
                visualDensity: const VisualDensity(vertical: -4, horizontal: -4)
              ),
              CheckboxListTile(
                value: true,
                onChanged: (value) {
                  // Lógica para el checkbox
                },
                title: const Text('Acepto las comunicaciones comerciales', style: TextStyle(fontSize: 12)),
                dense: true, // Hace que el CheckboxListTile sea más compacto
                controlAffinity: ListTileControlAffinity.leading, 
                visualDensity: const VisualDensity(vertical: -4, horizontal: -4),// Alinea el checkbox a la izquierda
              ),
            ],
          ),
          const SizedBox(height: 10),

          const CustomFilledButton(
            text: 'Crear cuenta',
            textColor: Colors.amber,
          ),
          

          const SizedBox(height: 40,)

        ],      
      )

    
    );
  }
}
