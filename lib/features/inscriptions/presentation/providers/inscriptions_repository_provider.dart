
import 'package:eventos_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:eventos_app/features/inscriptions/infrastructure/datasoruces/incription_datasource_impl.dart';
import 'package:eventos_app/features/inscriptions/infrastructure/repositories/inscription_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final inscriptionsRepositoryProvider = Provider<InscriptionRepositoryImpl>((ref){

  final accessToken = ref.watch(authProvider).idToken;

  final inscriptionsRepository = InscriptionRepositoryImpl(
    InscriptionDatasourceImpl(accessToken: accessToken)
  );
  return inscriptionsRepository;

});