//crud
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thebags_mobile/apis/endpoint.dart';

import '../models/user.dart';

class UserService {
  Future<List<User>> getListUsers() async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    if (token == null || token.isEmpty) return [];

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var url = Uri.parse(Endpoint.users);

    ///
    final response = await http.get(url, headers: headers);
    print(response.statusCode);
    if (response.statusCode == 200) {
      final List<dynamic> jsonDecoded = jsonDecode(response.body);
      print(jsonDecoded);
      return jsonDecoded.map((json) {
        return User.fromJson(json);
      }).toList();
    } else {
      throw jsonDecode(response.body)['message'] ?? 'Unknown error occur';
    }
  }
}
