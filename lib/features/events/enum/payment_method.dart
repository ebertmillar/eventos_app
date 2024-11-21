enum MetodoPago { tarjeta, efectivo, gpayApplePay, paypal, klarna }

// Genera una lista de nombres válidos desde el enum
final List<String> metodosValidos = MetodoPago.values.map((e) => e.name).toList();