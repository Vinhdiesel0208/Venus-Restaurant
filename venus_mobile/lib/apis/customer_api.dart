import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/customer_vinh.dart';
import '../apis/endpoint.dart';

class CustomerApi {
  Future<Customer> getCustomerByEmail(String email) async {
    final response = await http
        .get(Uri.parse('${Endpoint.getCustomerByEmail}?email=$email'));

    if (response.statusCode == 200) {
      return Customer.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load customer');
    }
  }

  Future<String> redeemPoints(
      String email, double totalAmount, String tableId) async {
    final response = await http.post(
      Uri.parse(
          '${Endpoint.redeemPoints}?email=$email&totalAmount=$totalAmount&tableId=$tableId'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to redeem points');
    }
  }

  Future<String> updatePoints(
      String email, double totalAmount, String tableId) async {
    final response = await http.post(
      Uri.parse(
          '${Endpoint.updatePoints}?email=$email&totalAmount=$totalAmount&tableId=$tableId'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to update points');
    }
  }
}
