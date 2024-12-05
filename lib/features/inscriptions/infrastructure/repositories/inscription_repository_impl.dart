import 'package:eventos_app/features/inscriptions/domain/datasources/inscription_datasource.dart';
import 'package:eventos_app/features/inscriptions/domain/entities/inscription.dart';
import 'package:eventos_app/features/inscriptions/domain/repositories/inscription_repository.dart';


  
class InscriptionRepositoryImpl extends InscriptionRepository{

  final InscriptionDatasource datasource;

  InscriptionRepositoryImpl(this.datasource);

  @override
  Future<void> cancelInscription(String id) {
    return datasource.cancelInscription(id);
  }

  @override
  Future<Inscription> createInscription(Map<String, dynamic> inscriptionData) {
    return datasource.createInscription(inscriptionData);
  }

  @override
  Future<void> deleteInscription(String id) {
   return datasource.deleteInscription(id);
  }

  @override
  Future<String> generateReport(String eventId) {
    return datasource.generateReport(eventId);
  }

  @override
  Future<Inscription> getInscriptionById(String id) {
    return datasource.getInscriptionById(id);
  }

  @override
  Future<List<Inscription>> getInscriptionsByEvent(String eventId) {
    return datasource.getInscriptionsByEvent(eventId);
  }

  @override
  Future<List<Inscription>> getInscriptionsByUser(String userId) {
    return datasource.getInscriptionsByUser(userId);
  }

  @override
  Future<void> sendNotification(String inscriptionId) {
    return datasource.sendNotification(inscriptionId);
  }

  @override
  Future<Inscription> updateInscription(String id, Map<String, dynamic> updatedData) {
    return datasource.updateInscription(id, updatedData);
  }

  @override
  Future<bool> verifyPaymentStatus(String id) {
    return datasource.verifyPaymentStatus(id);
  }
  
}