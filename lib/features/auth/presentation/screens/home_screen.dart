
import 'dart:io';

import 'package:eventos_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:eventos_app/features/events/presentation/providers/events_provider.dart';
import 'package:eventos_app/shared/helpers/form_date.dart';
import 'package:eventos_app/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeViewState createState() => HomeViewState();


}

class HomeViewState extends ConsumerState{

  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if( (scrollController.position.pixels + 350) >= scrollController.position.maxScrollExtent){
        ref.read(eventsProvider.notifier).loadNextPage();
      }
    });
  }


  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    final textTheme = Theme.of(context).textTheme;
    final eventsState = ref.watch(eventsProvider);
    final currentUserId = ref.watch(authProvider).currentUserId;

    

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
                mainAxisAlignment: MainAxisAlignment.spaceAround, // Espacio uniforme entre botones
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {},
                      child: const Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.location_on, color: Colors.black45),
                          Text('Selecciona ubicación', textAlign: TextAlign.center, style: TextStyle(color: Colors.black45)),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {},
                      child: const Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.calendar_month_outlined, color: Colors.black38),
                          Text('Seleccionar fecha', textAlign: TextAlign.center, style: TextStyle(color: Colors.black45)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
        
              const Divider(height: 1, thickness: 2,),        
              
              //Listado de eventos              
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.only(top: 20),
                  physics: const BouncingScrollPhysics() ,
                  controller: scrollController,
                  itemCount: eventsState.events.length, /// hacer length para determinar la cantidad de eventos a mostrar
                  itemBuilder: (context, index) {
                    
                    final event = eventsState.events[index];
                    final isCreator = currentUserId == event.createdBy;

                    return GestureDetector(
                      onTap: () => context.push('/event/${ event.id}'),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start, // Alinea todo a la izquierda
                        children: [
                          // Imagen
                          SizedBox(
                            width: double.infinity, // Toma todo el ancho disponible
                            height: 200,
                            child: buildEventImage(event.headerImage), 
                          ),

                          const SizedBox(height: 5),

                          // Nombre Evento
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Text(
                              event.name,
                              maxLines: 2,
                              textAlign: TextAlign.start, // Alineación a la izquierda del texto
                              style: textTheme.labelSmall?.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                height: 1.2
                              ),
                            ),
                          ),

                          const SizedBox(height: 10),

                          // Fecha del evento
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 7),
                            child: Row(
                              children: [
                                const Icon(Icons.calendar_today, color: Colors.orange, size: 20),
                                const SizedBox(width: 5),
                                Text(
                                  formatDateRange(event.startDate, event.endDate),
                                  style: TextStyle(
                                    color: Colors.orange.shade600,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 5),

                          // Lugar del evento
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 7),
                            child: Row(
                              children: [
                                const Icon(Icons.place, color: Colors.grey, size: 20),
                                const SizedBox(width: 5),
                                Text(
                                  event.location,
                                  style: const TextStyle(color: Colors.black54),
                                ),
                              ],
                            ),
                          ),
                          if (isCreator) 
                            IconButton(
                              onPressed: () {
                                context.push('/create-event/${event.id}');
                              },
                              icon: const Icon(Icons.edit),
                            ),

                          const SizedBox(height: 30),
                        ],
                      )

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


Widget buildEventImage(String headerImage) {
  late ImageProvider imageProvider;

  if (headerImage.isEmpty) {
    // Mostrar una imagen predeterminada si no hay una imagen
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      child: Image.network(
        'https://www.jordicarrio.com/content/img/gal/7185/c1706-1289-art.jpg',
        fit: BoxFit.cover,
      ),
    );
  }

  // Determinar si la imagen es una URL o un archivo local
  if (headerImage.startsWith('http')) {
    imageProvider = NetworkImage(headerImage);
  } else {
    imageProvider = FileImage(File(headerImage));
  }

  return ClipRRect(
    borderRadius: const BorderRadius.all(Radius.circular(20)),
    child: FadeInImage(
      fit: BoxFit.cover,
      image: imageProvider,
      placeholder: const NetworkImage('https://i.giphy.com/media/v1.Y2lkPTc5MGI3NjExZjZxeG1iYzJmejNidWtyeTZ3MWdzaGZ1OXRvcHA5ZTZscmhvd3cyeiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/3o7bu3XilJ5BOiSGic/giphy.gif'),
    ),
  );
}