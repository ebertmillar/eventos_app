import 'package:eventos_app/features/inscriptions/domain/entities/inscription.dart';

abstract class InscriptionDatasource {

  Future<Inscription> createInscription(Map<String, dynamic> inscriptionData);

  Future<Inscription> getInscriptionById(String id);

  Future<List<Inscription>> getInscriptionsByUser(String userId);

  Future<List<Inscription>> getInscriptionsByEvent(String eventId);

  /// Cancelar una inscripción (solo administrador o por incidencia)
  Future<void> cancelInscription(String id);

  /// Modificar una inscripción (solo administrador)
  Future<Inscription> updateInscription(String id, Map<String, dynamic> updatedData);

  /// Generar un reporte de inscripciones (e.g., en formato CSV o JSON)
  Future<String> generateReport(String eventId);

  /// Verificar el estado de pago de una inscripción
  Future<bool> verifyPaymentStatus(String id);

  /// Enviar notificación de inscripción (confirmación, QR, etc.)
  Future<void> sendNotification(String inscriptionId);

  /// Eliminar inscripción (solo administrador)
  Future<void> deleteInscription(String id);
}