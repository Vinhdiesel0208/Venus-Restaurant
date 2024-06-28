import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:thebags_mobile/models/booking_table.dart';
import 'package:thebags_mobile/apis/endpoint.dart';
import 'package:thebags_mobile/models/restaurant_table.dart';

class BookingTableApi {
  Future<BookingTable?> createBookingTable(BookingTable bookingTable) async {
    final url = Uri.parse(Endpoint.addBookingTable);
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    print('Token: $token');
    if (token == null || token.isEmpty) {
      print('Token is null or empty');
      return null; // or handle the error appropriately
    }

    final headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };
    final body = jsonEncode(bookingTable.toJson());

    final response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    print('POST $url');
    print('Request Body: $body');
    print('Response Status Code: ${response.statusCode}');

    if (response.statusCode == 201) {
      return BookingTable.fromJson(json.decode(response.body));
    } else {
      print('Failed to create booking: ${response.reasonPhrase}');
      return null;
    }
  }

  Future<List<RestaurantTable>> listTableByPerson(
      int personNumber, String date, String startTime, String endTime) async {
    final url = Uri.parse(
        '${Endpoint.listTableByPerson}?person_number=$personNumber&date=$date&start_time=$startTime&end_time=$endTime');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> body = jsonDecode(response.body);
      return body.map((json) => RestaurantTable.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load tables: ${response.reasonPhrase}');
    }
  }
}
