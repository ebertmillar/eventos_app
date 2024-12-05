import 'package:eventos_app/features/inscriptions/domain/entities/inscription.dart';
import 'package:eventos_app/features/inscriptions/domain/repositories/inscription_repository.dart';
import 'package:eventos_app/features/inscriptions/presentation/providers/inscriptions_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final inscriptionsProvider = StateNotifierProvider<InscriptionsNotifier, InscriptionsState>((ref) {
  
  final inscriptionRepository = ref.watch(inscriptionsRepositoryProvider);
  return InscriptionsNotifier(inscriptionRepository: inscriptionRepository);

});

class InscriptionsNotifier extends StateNotifier<InscriptionsState> {

  final InscriptionRepository inscriptionRepository;

  InscriptionsNotifier({
    required this.inscriptionRepository,
  }) : super(InscriptionsState());


  // Crear una inscripción
  Future<bool> createInscription(Map<String, dynamic> data) async {
    try {
      state = state.copyWith(isSubmitting: true);
      final inscription = await inscriptionRepository.createInscription(data);

      // Agregar la nueva inscripción al estado
      final updatedInscriptions = [...state.inscriptions, inscription];
      state = state.copyWith(isSubmitting: false, inscriptions: updatedInscriptions);

      return true; // Inscripción creada exitosamente
    } catch (e) {
      state = state.copyWith(isSubmitting: false);
      print('Error al crear inscripción: $e');
      return false; // Hubo un error
    }
  }
  
  
}



class InscriptionsState {
  final bool isSubmitting; 
  final List<Inscription> inscriptions;

  InscriptionsState({
    this.isSubmitting = false,
    this.inscriptions = const [],
  });

  InscriptionsState copyWith({
    bool? isSubmitting,
    List<Inscription>? inscriptions,
  }) {
    return InscriptionsState(
      isSubmitting: isSubmitting ?? this.isSubmitting,
      inscriptions: inscriptions ?? this.inscriptions,
    );
  }
}