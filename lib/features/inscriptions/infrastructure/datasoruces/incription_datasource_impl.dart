import 'package:dio/dio.dart';
import 'package:eventos_app/core/config/constants/environment.dart';
import 'package:eventos_app/features/inscriptions/domain/datasources/inscription_datasource.dart';
import 'package:eventos_app/features/inscriptions/domain/entities/inscription.dart';
import 'package:eventos_app/features/inscriptions/infrastructure/mappers/inscription_mapper.dart';

class InscriptionDatasourceImpl  extends InscriptionDatasource{

  late final Dio dio;
  final String accessToken;

  InscriptionDatasourceImpl({
    required this.accessToken,
    }): dio = Dio(
    BaseOptions(
      baseUrl: Environment.apiUrl,
      headers: {
        'Authorization': 'Bearer $accessToken'
      }
    ));

  @override
  Future<void> cancelInscription(String id) {
    throw UnimplementedError();
  }

  @override
  Future<Inscription> createInscription(Map<String, dynamic> inscriptionData) async {
    final response = await dio.post('', data: inscriptionData);

    final inscription = InscriptionMapper.jsonToEntity(response.data);
    return inscription;
  }

  @override
  Future<void> deleteInscription(String id) {
    throw UnimplementedError();
  }

  @override
  Future<String> generateReport(String eventId) {
    throw UnimplementedError();
  }

  @override
  Future<Inscription> getInscriptionById(String id) {
    throw UnimplementedError();
  }

  @override
  Future<List<Inscription>> getInscriptionsByEvent(String eventId) {
    throw UnimplementedError();
  }

  @override
  Future<List<Inscription>> getInscriptionsByUser(String userId) {
    throw UnimplementedError();
  }

  @override
  Future<void> sendNotification(String inscriptionId) {
    throw UnimplementedError();
  }

  @override
  Future<Inscription> updateInscription(String id, Map<String, dynamic> updatedData) {
    throw UnimplementedError();
  }

  @override
  Future<bool> verifyPaymentStatus(String id) {
    throw UnimplementedError();
  }

}