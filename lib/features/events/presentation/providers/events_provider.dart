

import 'package:eventos_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:eventos_app/features/events/domain/domain.dart';
import 'package:eventos_app/features/events/presentation/providers/events_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



final eventsProvider = StateNotifierProvider<EventsNotifier,EventsState>((ref) {
  
  final eventsRepository = ref.read(eventsRepositoryProvider);
  final currentUserId = ref.read(authProvider).currentUserId;
  
  return EventsNotifier(eventsRepository: eventsRepository, currentUserId: currentUserId,);

});


class EventsNotifier extends StateNotifier<EventsState> {

  final EventsRepository eventsRepository;
  final String? currentUserId;  // Recibimos el currentUserId

  EventsNotifier({
    required this.eventsRepository,
    required this.currentUserId,
  }) :super(EventsState()){
    loadNextPage();
  }
  
  Future<bool> createOrUpdateEvent(Map<String,dynamic> eventLike) async {

    try {

      // Si no tiene 'createdBy', asignamos el ID del usuario actual
      if (!eventLike.containsKey('createdBy')) {
        eventLike['createdBy'] = currentUserId;  // Asignamos el currentUserId al campo 'createdBy'
      }
      
      final event = await eventsRepository.createUpdateEvent(eventLike);
      final isEventInList = state.events.any(( element )=> element.id == event.id  );

      if (!isEventInList) {
        state = state.copyWith(
          events: [...state.events, event]
        );
        return true;
      }
      

      state = state.copyWith(
        events: state.events.map(
          (element) => ( element.id == event.id) ? event : element).toList()
      );

      return true;



    } catch (e) {
      return false;
    }
  }

  Future loadNextPage() async {

    if( state.isLoading || state.isLastPage) return;

    state = state.copyWith(
      isLoading: true,
    );

    final events = await eventsRepository
      .getEventByPage(limit: state.limit, offset: state.offset);

      if(events.isEmpty){
        state = state.copyWith(
          isLastPage: true, 
          isLoading: false, 
        );
        return;
      }

      state = state.copyWith(
        isLastPage: false,
        isLoading: false,
        offset: state.offset + 10,
        events: [...state.events, ...events]
      );
  }

}


class EventsState {

  final bool isLastPage;
  final int limit;
  final int offset;
  final bool isLoading;
  final List<Event> events;

  EventsState({
    this.isLastPage = false, 
    this.limit = 10, 
    this.offset = 0, 
    this.isLoading = false, 
    this.events = const [],
  });

  EventsState copyWith({
    bool? isLastPage,
    int? limit,
    int? offset,
    bool? isLoading,
    List<Event>? events,

  }) => EventsState(
    isLastPage: isLastPage ?? this.isLastPage,
    limit: limit ?? this.limit,
    offset: offset ?? this.offset,
    isLoading: isLoading ?? this.isLoading,
    events:  events ?? this.events,
  );

}