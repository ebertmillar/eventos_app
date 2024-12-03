import 'package:eventos_app/features/events/domain/entities/event.dart';
import 'package:eventos_app/features/events/presentation/providers/event_provider.dart';
import 'package:eventos_app/shared/helpers/form_date.dart';
import 'package:eventos_app/shared/shared.dart';
import 'package:eventos_app/shared/widgets/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class EventScreen extends ConsumerWidget {
  final String eventId;

  const EventScreen({super.key, required this.eventId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final eventState = ref.watch(eventProvider( eventId ) );
    //final size = MediaQuery.of(context).size;

    return Scaffold(
      body: eventState.isLoading
          ? const FullScreenLoader()
          : CustomScrollView(
              physics: const ClampingScrollPhysics(),
              slivers: [
                _CustomSliverAppBar(event: eventState.event!,),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => _EventDetails(event: eventState.event!,),
                    childCount: 1
                  )
                )
              ],
            ),
    );
    
  }
}

class _EventDetails extends StatelessWidget {

  final Event event;

  const _EventDetails({ required this.event });



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(padding: EdgeInsets.all(10)),
          Row(
              children: [
                const Icon(Icons.calendar_today, color: Colors.orange, size: 20),
                const SizedBox(width: 8),
                Text(
                  formatDateRange(event.startDate, event.endDate),
                  style: TextStyle(color: Colors.orange.shade600, fontWeight: FontWeight.bold),
                ),
              ],
            ),

            const SizedBox(height: 8,),

            Row(
              children: [
                const Icon(Icons.place, color: Colors.grey, size: 20),
                const SizedBox(width: 8),
                Text(
                  event.location,
                  style: const TextStyle(color: Colors.black54),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              "Descripción del Evento",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              event.description ,
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),

            const SizedBox(height: 15),

            const Center(
              child: SizedBox(
                width: double.infinity, // Toma todo el ancho disponible
                child: _DownloadProgramButton(),
              ),
            ),
            
            const SizedBox(height: 25),

            Center(
              child: CustomFilledButton(
                text: 'Inscribirse',
                onPressed: 
                 () =>  GoRouter.of(context).go('/inscription', extra: event)
                
              ),
            ),

             const SizedBox(height: 35),



            const Text(
              "Agenda del Evento",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),
            
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: event.agenda.map((day) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5), // Espaciado entre días
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Título del día con fecha
                      Text(
                        "Día : ${formatDay(day.day)}",
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black54),
                      ),
                      const SizedBox(height: 8), // Separador entre el título del día y las actividades

                      // Lista de actividades
                      ...day.activities.map((activity) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 5),
                          child: Text(
                            "${activity.startTime} - ${activity.endTime}: ${activity.description}",
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                );
              }).toList(),
            ),


            
            const SizedBox(height: 100)

        ],
      ),

      
    );
  }
}

class _DownloadProgramButton extends StatelessWidget {
  const _DownloadProgramButton();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15), // Altura del botón
        backgroundColor: Colors.white, // Fondo blanco
        foregroundColor: Colors.black, // Color del texto e ícono
        side: const BorderSide(color: Colors.black45), // Borde del botón
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Bordes redondeados
        ),
      ),
      onPressed: () {

      },
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distribuye los elementos
        children: [
          Text(
            'Descargar Programa',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Icon(
            Icons.paste_sharp,
            size: 28, // Tamaño del ícono
          ),
        ],
      ),
    );
  }
}




class _CustomSliverAppBar extends StatelessWidget {

  final Event event;

  const _CustomSliverAppBar({required this.event});

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.35,
      foregroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        title: Text(
          event.name,
          style: const TextStyle(fontSize: 16, color: Colors.white),
          textAlign: TextAlign.start,
        ),
        background: Stack(
          children: [
            SizedBox.expand(
              child: Image.network(
                event.headerImage.isNotEmpty
                  ? event.headerImage 
                  : "https://media.istockphoto.com/id/525560961/es/foto/segovia-espa%C3%B1a-acueducto.jpg?s=612x612&w=0&k=20&c=dAebHX1SW41UbXCnD49TM467w3GjA_wIe6G8Z6pBPNI=",
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox.expand(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.35, 1.0],
                    colors: [
                      Colors.transparent,
                      Colors.black87
                    ]
                  )
                ),
              ),
            ),

            const SizedBox.expand(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomCenter,
                    stops: [0.0, 0.3],
                    colors: [
                      Colors.black87,
                      Colors.transparent,
                    ]
                  )
                ),
              ),
            ),
          ],
        ),

      ),
    );
  }
}

bool isInscriptionValid(Event event) {
  final now = DateTime.now();
  final startInscription = DateTime.now(); // Inscripción empieza hoy
  final endInscription = event.startDate; // Inscripción termina al inicio del evento

  return now.isAfter(startInscription) && now.isBefore(endInscription) || now.isAtSameMomentAs(endInscription);
}
