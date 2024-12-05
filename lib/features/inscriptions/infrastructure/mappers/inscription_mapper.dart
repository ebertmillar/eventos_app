import 'package:eventos_app/features/inscriptions/domain/entities/inscription.dart';

class InscriptionMapper {

  static Inscription jsonToEntity(Map<String, dynamic> json) {
    return Inscription(
      id: json["id"] ?? '',
      userId: json["userId"],
      eventId: json["eventId"],
      amountPaid: double.parse(json["amountPaid"].toString()),
      date: DateTime.parse(json["date"]),
      paymentMethod: json["paymentMethod"],
      ticketCode: json["ticketCode"] ?? '',
      isPaid: json["isPaid"] ?? false,
      status: json["status"] ?? 'pending',
    );
  }
  
}