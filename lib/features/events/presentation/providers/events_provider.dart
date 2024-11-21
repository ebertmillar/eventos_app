
import 'package:eventos_app/features/events/domain/domain.dart';
import 'package:eventos_app/features/events/presentation/providers/events_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



final eventsProvider = StateNotifierProvider<EventsNotifier,EventsState>((ref) {
  
  final eventsRepository = ref.read(eventRepositoryProvider);
  
  return EventsNotifier(eventsRepository: eventsRepository);

});


class EventsNotifier extends StateNotifier<EventsState> {

  final EventRepository eventsRepository;

  EventsNotifier({
    required this.eventsRepository
  }) :super(EventsState()){
    loadNextPage();
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