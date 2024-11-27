
import 'package:eventos_app/features/events/domain/domain.dart';
import 'package:eventos_app/features/events/presentation/providers/events_repository_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final eventProvider = StateNotifierProvider.autoDispose.family<EventNotifier, EventState, String >(
  (ref, eventId) {

    final eventsRepository = ref.watch(eventsRepositoryProvider);

    return EventNotifier(
      eventsRepository: eventsRepository, 
      eventId: eventId
    );
});


class EventNotifier extends StateNotifier<EventState> {
  
  final EventsRepository eventsRepository;

  EventNotifier({
    required this.eventsRepository,
    required String eventId,
  }): super(EventState(id: eventId)){
    loadEvent();
  }

  Event newEmptyEvent(){
    return Event(
      id: 'new', // Identificador inicial
      createdBy: '', // Usuario creador
      name: '', // Nombre del evento
      description: '', // Descripción del evento
      startDate: DateTime.now(), // Fecha de inicio predeterminada (hoy)
      endDate: DateTime.now(), // Fecha de fin predeterminada (hoy)
      startTime: const TimeOfDay(hour: 0, minute: 0), // Hora de inicio predeterminada (00:00)
      endTime: const TimeOfDay(hour: 23, minute: 59), // Hora de fin predeterminada (23:59)
      differentSchedulesPerDay: false, // Por defecto, un solo horario para todo el evento
      location: '', // Ubicación vacía
      headerImage: '', // Imagen de cabecera vacía
      inscriptionStartDate: DateTime.now(), // Fecha de inicio de inscripción predeterminada (hoy)
      inscriptionEndDate: DateTime.now(), // Fecha de fin de inscripción predeterminada (hoy)
      inscriptionStartTime: const TimeOfDay(hour: 0, minute: 0), // Hora de inicio de inscripción predeterminada (00:00)
      inscriptionEndTime: const TimeOfDay(hour: 23, minute: 59), // Hora de fin de inscripción predeterminada (23:59)
      isPublic: true, // Por defecto, el evento es público
      capacity: 0, // Capacidad predeterminada (sin límite)
      inscriptionCost: 0.0, // Costo de inscripción predeterminado (gratis)
      paymentMethods: [], // Lista vacía de métodos de pago
      agenda: [], // Agenda vacía
      ageRestriction: false, // Sin restricción de edad por defecto
      contactName: '', // Nombre de contacto vacío
      contactPhone: '', // Teléfono de contacto vacío
      contactEmail: '', // Correo electrónico de contacto vacío
      createdAt: DateTime.now(), // Fecha de creación predeterminada (hoy)
    );
  }

  Future<void> loadEvent() async {
    try {

      if(state.id == 'new'){
        state  = state.copyWith(
          isLoading: false,
          event: newEmptyEvent(),
        );
        return;
      }

      final event = await eventsRepository.getEventById(state.id);

      state = state.copyWith(
        isLoading: false,
        event: event
      );
    } catch (e) {
      print(e);
    }
  }


}

class EventState {
  final String id;
  final Event? event;
  final bool isLoading;
  final bool isSaving;

  EventState({
    required this.id,
    this.event,
    this.isLoading = true,
    this.isSaving = false,
  });

  EventState copyWith({
    String? id,
    Event? event,
    bool? isLoading,
    bool? isSaving,
  }) =>EventState(
      id: id ?? this.id,
      event: event ?? this.event,
      isLoading: isLoading ?? this.isLoading,
      isSaving: isSaving ?? this.isSaving,
    );

    
  



}