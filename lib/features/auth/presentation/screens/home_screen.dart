
import 'package:eventos_app/features/events/presentation/providers/events_provider.dart';
import 'package:eventos_app/shared/helpers/form_date.dart';
import 'package:eventos_app/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeViewState createState() => HomeViewState();


}

class HomeViewState extends ConsumerState{

  @override
  void initState() {
    super.initState();
    //ref.read(eventsProvider.notifier).loadNextPage();
  }


  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    final textTheme = Theme.of(context).textTheme;

    final eventsState = ref.watch(eventsProvider);

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
                  itemCount: eventsState.events.length, /// hacer length para determinar la cantidad de eventos a mostrar
                  itemBuilder: (context, index) {
                    final event = eventsState.events[index];
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
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Text(
                              event.name,
                              maxLines: 2,
                              style: textTheme.labelSmall?.copyWith(color: Colors.black , fontWeight: FontWeight.bold, fontSize: 20)                        
                            ),
                          ),
                        ),
        
                        //Fecha y lugar del evento
        
                        SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    formatDateRange(event.startDate, event.endDate),
                                    style: textTheme.bodyMedium?.copyWith(color: Colors.orange.shade500 , fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    event.location, 
                                    style: textTheme.bodyMedium?.copyWith(color: Colors.black45),
                                  ),
                                ),
                                    
                              ],
                            ),
                          ),
                        ),
        
                        const SizedBox(height: 20),
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