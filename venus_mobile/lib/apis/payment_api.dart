import 'dart:convert';
import 'package:http/http.dart' as http;
import 'endpoint.dart';

class PaymentApi {
  Future<String> getVNPayUrl(double amount, String description) async {
    final response = await http.post(
      Uri.parse(Endpoint.vnpayPayment), // Sử dụng URL từ Endpoint
      body: jsonEncode({
        'amount': amount,
        'description': description,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['url'];
    } else {
      throw Exception('Failed to create VNPay payment URL');
    }
  }

  Future<String> getPayPalUrl(double amount, String description) async {
    final response = await http.post(
      Uri.parse(Endpoint.paypalPayment), // Sử dụng URL từ Endpoint
      body: jsonEncode({
        'amount': amount,
        'description': description,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['url'];
    } else {
      throw Exception('Failed to create PayPal payment URL');
    }
  }
}
