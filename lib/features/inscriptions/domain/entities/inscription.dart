class Inscription {

  final String id; 
  final String userId;
  final String eventId; 
  final double amountPaid;
  final DateTime date; 
  final String paymentMethod; 
  final String ticketCode; //QR o string unico
  final bool isPaid; 
  final String status;

  Inscription({
    required this.id,
    required this.userId,
    required this.eventId,
    required this.amountPaid,
    required this.date,
    required this.paymentMethod,
    required this.ticketCode,
    required this.isPaid,
    required this.status
  });
}
