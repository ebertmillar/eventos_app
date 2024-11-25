
import 'package:eventos_app/features/events/domain/domain.dart';
import 'package:eventos_app/features/events/presentation/providers/events_repository_provider.dart';
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

  Future<void> loadEvent() async {
    try {
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