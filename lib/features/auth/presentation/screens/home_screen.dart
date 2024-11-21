
import 'package:eventos_app/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: const CustomAppbar(),
      body: GestureDetector(
        onTap: () {
           FocusScope.of(context).unfocus(); // Desactiva el foco del TextField al presionar en cualquier lugar de la pantalla
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Fila para la ubicación
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.location_on , color: Colors.black45,),
                  const SizedBox(width: 5),
                  const Text('Tu ubicación: ', style: TextStyle(fontSize: 15, color: Colors.black45)),
                  TextButton(
                    onPressed: (){},
                    child: Row(
                      children: [
                        Text('Segovia', style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
                        const Icon(Icons.arrow_drop_down_rounded,color: Colors.black,)//icono para poder seleccionar ubicación
                      ],
                    ),
                  ),

                ],
              ),
              
              const SizedBox(height: 15),
              
              //Campo para buscar Eventos
          
              TextField(
                decoration: InputDecoration(
                  //filled: true,
                  //fillColor: Colors.black12,
                  hintText: 'Buscar un evento',
                  hintStyle: const TextStyle(color: Colors.black45 ),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  prefixIcon: const Icon(Icons.search, color: Colors.black45,)
                ),
              ),
          
              const SizedBox(height: 15),
          
              //Seleccionar Ubiacion y Fecha
          
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: (){}, 
                    child: const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.location_on, color: Colors.black45),
                        Text('Selecciona ubicación', style: TextStyle(color: Colors.black45))
                      ],
                    )
                  ),
          
                  TextButton(
                    onPressed: (){}, 
                    child: const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.calendar_month_outlined, color: Colors.black38),
                        Text('Selecciona ubicación', style: TextStyle(color: Colors.black45))
                      ],
                    )
                  )
          
                ],
              ),
        
              const Divider(height: 30, thickness: 2,),
        
              //Listado de eventos
              
              Expanded(
                child: ListView.builder(
                  itemCount: 4, /// hacer length para determinar la cantidad de eventos a mostrar
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
        
                        //Imagen
                        SizedBox(
                          width:360,
                          height: 200,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              'https://www.jordicarrio.com/content/img/gal/7185/c1706-1289-art.jpg',
                              fit: BoxFit.cover,
                              width: 360,
                            ),
                            
                          ),
                        ),
        
                        const SizedBox(height: 10),
        
                        //Nombre Evento
                        SizedBox(
                          width: 360,
                          child: Text(
                            'Nombre del Evento',
                            maxLines: 2,
                            style: textTheme.bodyLarge?.copyWith(color: Colors.black , fontWeight: FontWeight.bold, fontSize: 20)                        
                          ),
                        ),
        
                        //Fecha y lugar del evento
        
                        SizedBox(
                          width: 360,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Fecha del evento', 
                                style: textTheme.bodyLarge?.copyWith(color: Colors.amber , fontWeight: FontWeight.bold),
                              ),
        
                              Text(
                                'Lugar del evento', 
                                style: textTheme.bodyLarge?.copyWith(color: Colors.black45),
                              ),
        
                            ],
                          ),
                        ),
        
                        const SizedBox(height: 40),
                      ],
                    );
                  },
                
                ),
              ),
        
        
          
          
            ],
          ),
        ),
      ),

      
       

      bottomNavigationBar: const CustomNavigationbar()
    );
  }
}
