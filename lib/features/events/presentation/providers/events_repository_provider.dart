
import 'package:eventos_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:eventos_app/features/events/infrastructure/datasources/event_datasource_impl.dart';
import 'package:eventos_app/features/events/infrastructure/repositories/event_repositoy_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final eventsRepositoryProvider = Provider<EventRepositoyImpl>((ref){

  final accessToken = ref.watch(authProvider).idToken;
  final userId = ref.watch(authProvider).currentUserId;

  final eventsRepository = EventRepositoyImpl(
    EventDatasourceImpl(accessToken: accessToken, userId: userId)
  );
  return eventsRepository;

});