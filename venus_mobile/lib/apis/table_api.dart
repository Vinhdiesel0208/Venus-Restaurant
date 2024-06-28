import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/restaurant_table.dart';
import '../helpers/auth_helper.dart';
import 'endpoint.dart';

class TableApi {
  static const String url = Endpoint.getTables;

  Future<List<RestaurantTable>> fetchTables() async {
    final token = await AuthHelper.getToken();
    if (token == null) {
      throw Exception('Token is null');
    }

    final response = await http.get(Uri.parse(url), headers: {
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      List<RestaurantTable> tables =
          body.map((dynamic item) => RestaurantTable.fromJson(item)).toList();
      return tables;
    } else {
      throw Exception('Failed to load tables');
    }
  }

  Future<void> checkInTable(int tableId) async {
    final token = await AuthHelper.getToken();
    if (token == null) {
      throw Exception('Token is null');
    }

    final response = await http.post(
      Uri.parse('${Endpoint.checkinTable}/$tableId/checkin'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to check in table');
    }
  }

  Future<void> checkOutTable(int tableId) async {
    final token = await AuthHelper.getToken();
    if (token == null) {
      throw Exception('Token is null');
    }

    final response = await http.post(
      Uri.parse('${Endpoint.checkoutTable}/$tableId/checkout'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to check out table');
    }
  }
}
