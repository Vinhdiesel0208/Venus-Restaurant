// lib/apis/contact_api.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thebags_mobile/models/restaurant_table.dart';
import '../models/contact.dart';
import 'endpoint.dart';

class ContactApi {
  // Fetch all contacts
  Future<List<Contact>> getAllContacts() async {
    final response = await http.get(Uri.parse(Endpoint.getContacts));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((contact) => Contact.fromJson(contact)).toList();
    } else {
      return [];
    }
  }

  // Post a new contact
  Future<Contact?> createContact(Contact contact) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token'); // Lấy token đã lưu
    final response = await http.post(
      Uri.parse(Endpoint.getContacts),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token', // Thêm dòng này
      },
      body: json.encode(contact.toJson()),
    );

    if (response.statusCode == 201) {
      return Contact.fromJson(json.decode(response.body));
    } else {
      // Xử lý lỗi ở đây
      return null;
    }
  }
}
