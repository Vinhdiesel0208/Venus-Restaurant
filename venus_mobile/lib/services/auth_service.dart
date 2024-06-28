import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../helpers/auth_helper.dart';
import '../apis/endpoint.dart';

class AuthService {
  Future<String> loginWebAccount(String email, String password) async {
    var headers = {'Content-Type': 'application/json'};
    var url = Uri.parse(Endpoint.signIn);
    Map body = {'username': email, 'password': password};

    final response =
        await http.post(url, headers: headers, body: jsonEncode(body));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      if (json.containsKey('accessToken')) {
        // Lưu token bằng AuthHelper
        await AuthHelper.saveToken(json['accessToken']);
        String role = json['roles'][0];
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('fullName', json['fullName']);
        prefs.setString('email', json['email']);
        prefs.setString('role', role);
        // Lưu tên đăng nhập và mật khẩu
        prefs.setString('savedEmail', email);
        prefs.setString('savedPassword', password);
        return role;
      } else {
        throw Exception('Login failed: No access token found in the response');
      }
    } else {
      throw Exception('Failed to log in');
    }
  }
}
